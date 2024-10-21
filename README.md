disk notify
===========


send notify if disk avail space low

it can monit multi mountpoint with specified thresholds  
by bash associative array. (key-value pairs)

```sh
declare -A mount_thresholds=(
    ["/"]="5120"      # 5 GB in MB
    ["/tmp"]="1024"   # 1 GB in MB
)
```

<br>

supported notify backends
- pushplus
- serverchan

<br>

logs
- disk_space_file=df_hist.log   //disk avali space log
- send_log=send_hist.log        //send noitfy log

<br>

notify frequency
- push_delay=30 //push interval (will adjusted dynamically)

<br>

check frequency
- save_interval=3600  // 1 hour
- check_interval=300  // 5 min

