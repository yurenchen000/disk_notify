#!/bin/bash

dir=`dirname $(readlink -f $BASH_SOURCE)`

# -----
echoR(){ echo -e "\e[31m$@\e[0m"; }
echoG(){ echo -e "\e[32m$@\e[0m"; }
echoY(){ echo -e "\e[33m$@\e[0m"; }
echoH(){ echo -e "\e[01;32;40m$@\e[0m"; }

# ----- conf
# Set the save interval (in seconds)
save_interval=$((1 * 3600))  # 1 hour (adjust as needed)
check_interval=300

# save_interval=5 
# check_interval=5

temp_tit='${hostname} ${mount_point} Low Disk Space Warning'
temp_msg='Available space on ${mount_point} is ${avail_gb}GB, which is below the ${threshold_gb}GB threshold.'

# File to save disk space information
disk_log="disk_hist.log"

# Define mount_point : threshold
declare -A mount_thresholds=(
    ["/"]="5120"      # 5 GB in MB
    ["/tmp"]="1024"   # 1 GB in MB
)

# Source conf
source $dir/push_notify.sh
source $dir/_disk_notify_global
[ -f ~/.config/_disk_notify ] && source ~/.config/_disk_notify

load_push_impl

# Function to check disk space, notify if below threshold, and save information
get_disk_space() {
    local mount_point="$1"
    local threshold="$2"

    # Get available space in MB
    local avail_mb=$(df -m "$mount_point" | awk 'NR==2 {print $4}')

    # Save disk space information
    #echo "$(date '+%Y-%m-%d %H:%M:%S'): $mount_point ${avail_gb}GB" >> "$disk_log"

    echo "$avail_mb"  # Return available space in MB for comparison
}
check_threashold_send_notify(){
    local mount_point="$1"
    local threshold="$2"
    local avail_mb="$3"
    # Convert MB to GB with one decimal place
    local avail_gb=$(echo "scale=1; $avail_mb / 1024" | bc)

    local threshold_mb="$threshold"
    local threshold_gb=$(echo "scale=1; $threshold / 1024" | bc)

    local hostname="$HOSTNAME"

    # local mount_point_threshold="$threshold"
    # local mount_point_available="$avail_mb"
    # local mount_point_avail_MB="$avail_mb"
    # local mount_point_avail_GB="$avail_gb"

    if (( avail_mb < threshold )); then
        local tit=`eval echo \"$temp_tit\"`
        local msg=`eval echo \"$temp_msg\"`
        # push_notify "$title" "$msg"
        push_notify_append "$tit" "$msg" >/dev/null
    fi
}

show_thresholds(){
    echoY "-------thresholds"
    for mount_point in "${!mount_thresholds[@]}"; do
        fmt_size=`numfmt --from iec --to iec "${mount_thresholds[$mount_point]}"M`
        # printf "%8d   %s\n" "fmt_size" "$mount_point" 
        printf "%8s   %s\n" "$fmt_size" "$mount_point" 
    done
    echoY "-------check interval: $check_interval sec"
    echoY "-------save  interval: $save_interval sec"
    echoY "-------push   backend: $push_backend"
    echo
}

show_thresholds

# last_save_time=0
declare -A last_save_time
declare -A last_available
declare -A value_changed

# Main loop
while true; do
    current_time=`date +%s`

    for mount_point in "${!mount_thresholds[@]}"; do
        available=$(get_disk_space "$mount_point" "${mount_thresholds[$mount_point]}")
        
        #### notify
        check_threashold_send_notify "$mount_point" "${mount_thresholds[$mount_point]}" "$available"

        #### log
        # Check if available space has changed
        if [[ -z "${last_available[$mount_point]}" ]] || [[ "$available" != "${last_available[$mount_point]}" ]]; then
            last_available[$mount_point]=$available
            value_changed[$mount_point]=true
        else
            value_changed[$mount_point]=false
        fi

        # Convert MB to GB with one decimal place for saving
        avail_gb=$(echo "scale=1; $available / 1024" | bc)

        fmt=''
        fmt0=$'\e[0m'
        stat=''
        if [ ${value_changed[$mount_point]} = "true" ]; then
            fmt=$'\e[33m'
            stat='changed '
        fi
        if (( current_time - ${last_save_time[$mount_point]:-0} >= save_interval )); then
            stat="${stat}interval"
        fi

        # Save disk space information if value changed or save interval reached
        if [ ${value_changed[$mount_point]} = "true" ] || (( current_time - ${last_save_time[$mount_point]:-0} >= save_interval )); then
            # echo "`date '+%Y-%m-%d %H:%M:%S'`: ${avail_gb}GB $mount_point " | tee /dev/tty >> "$disk_log"
            # echo "$fmt`date '+%Y-%m-%d %H:%M:%S'`: ${available} = ${avail_gb}GB $mount_point "$'\t'" $fmt0" | tee /dev/tty >> "$disk_log"
            # printf "$fmt`date '+%Y-%m-%d %H:%M:%S'`: %8d = %8s  %-20s $stat $fmt0\n" ${available} ${avail_gb}GB $mount_point | tee /dev/tty >> "$disk_log"
            printf "$fmt`date '+%Y-%m-%d %H:%M:%S'`: %8d = %8s  %-20s $stat $fmt0\n" ${available} ${avail_gb}GB $mount_point | tee -a "$disk_log"
            last_save_time[$mount_point]=$current_time
        fi

        ## send if has append
        push_notify_final
    done

    # Update last save time if any value changed or save interval reached
    # if [[ " ${value_changed[@]} " =~ " true " ]] || (( current_time - last_save_time >= save_interval )); then
    #     last_save_time=$current_time
    # fi

    # Sleep for 5 minutes
    sleep $check_interval
done
