
# send_key=${send_key:-'set your sendkey at conf'}
send_log=${send_log:-'send_hist.log'}


## --------- direct send
## msg is markdown, new-line need '  \n' OR '\n\n'
do_push_notify(){
    local tit="$1"
    local msg="$2"
	local backend

	for backend in $push_backend; do
	case "$backend" in
  telegram) do_push_$backend  "$tit" "$msg";;
    feishu) do_push_$backend  "$tit" "$msg";;
    wework) do_push_$backend  "$tit" "$msg";;
  dingtalk) do_push_$backend  "$tit" "$msg";;
  pushplus) do_push_$backend  "$tit" "$msg";;
  wxpusher) do_push_$backend  "$tit" "$msg";;
serverchan) do_push_$backend  "$tit" "$msg";;
         *) echo 'choose a push backend by set push_backend in conf';;
	esac
	done

    # echo "==`date -Is`: $tit: $msg"  >&2
    echo -e "\e[31m==`date -Is`: $tit: $msg\e[0m"  | tee /dev/tty >> $send_log
}

load_push_impl(){
	local backend

	for backend in $push_backend; do
	case "$backend" in
  telegram) source $dir/push_impl.$backend.sh;;
    feishu) source $dir/push_impl.$backend.sh;;
    wework) source $dir/push_impl.$backend.sh;;
  dingtalk) source $dir/push_impl.$backend.sh;;
  pushplus) source $dir/push_impl.$backend.sh;;
  wxpusher) source $dir/push_impl.$backend.sh;;
serverchan) source $dir/push_impl.$backend.sh;;
	     *) echo 'choose push backend by set push_backend in conf';;
	esac
	done
}

push_old=0    # last push time
push_cnt=0    # push count (last hour)
push_delay=30 # push interval (will adjusted dynamically)
push_notify(){
	local tit="$1"
	local msg="$2"

	push_now=`date +%s`
	if [ $((push_now-push_old)) -le $push_delay ]; then
		echo -e "\e[31m push_msg too fast ($push_cnt recent), wait $push_delay sec!\e[0m"
		return
	fi

	push_cnt=$((push_cnt+1))		#push_cnt
	if [ $((push_now-push_old)) -ge 3600 ]; then
		push_cnt=0		#1hour clear
	fi

	if [ $push_cnt -ge 2 ]; then	#push_delay
		push_delay=600	#10min
	else
		push_delay=30	#.5min
	fi

	push_old=$push_now
	do_push_notify "$tit" "$msg"
	echo
}


# push_notify hello  "hello, world  
# bbb"

## --------- append send
send_body=''
send_titl=''
push_notify_append(){
    local tit="$1"
    local msg="$2"
    send_titl="$tit"
    send_body="$send_body$msg  
"
}

push_notify_final(){
    [ -n "$send_body" ] && {
        send_body="${send_body%%$'\n'}"
        push_notify "$send_titl" "$send_body"
    }

    send_titl=''
    send_body=''
}


# push_notify_append hello1  body1
# push_notify_append hello2  body2
# push_notify_final
