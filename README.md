disk notify
===========


send notify if disk avail space low

[README 中文](README_CN.md)

<img src=https://i.imgur.com/zLzLm0B.jpeg alt="only-bash.jpg" height=300 />


- Lightweight: only bash, df, curl
- Focus: only notify alert if space low
- Accuracy: partition specified threshold
- Reliable: multiple push channels

<br>

## 🛠️ Settings
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
- telegram bot
- feishu bot
- wework bot
- dingtalk bot
- pushplus
- wxpusher
- serverchan

<br>

logs
- disk_log=disk_hist.log   //disk space log
- send_log=send_hist.log   //send noitfy log

<br>

notify frequency
- push_delay=30 //push interval (will adjusted dynamically)

<br>

check frequency
- save_interval=3600  // 1 hour
- check_interval=300  // 5 min

<br>

## 🚀 Usage
download from https://github.com/yurenchen000/disk_notify/releases/latest  
and uncompress it.

// edit conf base on example  
```
cp -pv _disk_notify_global.example _disk_notify_global  
// modify the conf according to your needs  
```

conf file
- ./_disk_notify_global
- ~/.config/_disk_notify

<br>

// run in background
```
nohup ./disk_notify.sh &> disk_notify.out &
```

<br>

## Other Bash Script

[![other bash repos](https://res.ez2.fun/svg/repos-bash_script.svg)](https://github.com/yurenchen000/yurenchen000/blob/main/repos.md#bash-scripts)

