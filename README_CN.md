磁盘空间告警
===========

当磁盘可用空间低时 发送告警通知

## 🛠️ 设置
可以监控多个分区(挂载点)，并分别设置阈值  
(使用bash关联数组)

```sh
declare -A mount_thresholds=(
    ["/"]="5120"      # 5 GB，单位MB
    ["/tmp"]="1024"   # 1 GB，单位MB
)
```

<br>

支持的通知方式
- Telegram 机器人 (需代理 可通过 https_proxy= 指定)
- Feishu 机器人
- Pushplus
- Wxpusher
- Server酱

<br>

日志
- disk_log=disk_hist.log   //磁盘空间日志
- send_log=send_hist.log   //发送通知日志

<br>

通知频率
- push_delay=30  //推送间隔（会动态调整）

<br>

检查频率
- save_interval=3600  // 1小时 记录 disk_log (空间变化时也记录)
- check_interval=300  // 5分钟

<br>

## 🚀 使用方法
从 https://github.com/yurenchen000/disk_notify/releases/latest 下载并解压。

//基于示例文件 编辑配置
```
cp -pv _disk_notify_global.example _disk_notify_global  
//根据需要修改配置文件
```

配置文件路径
- ./_disk_notify_global
- ~/.config/_disk_notify

<br>

//后台运行
```
nohup ./disk_notify.sh &> disk_notify.out &
```

