
## --------- push via serverChan

serverchan_sendkey=${serverchan_sendkey:-'set your sendkey at conf'}

## msg is markdown, new-line need '  \n' OR '\n\n'
do_push_serverchan(){
    local tit="$1"
    local msg="$2"
    curl -s "https://sctapi.ftqq.com/$serverchan_sendkey.send" \
     --data-urlencode "title=$tit" \
     --data-urlencode "desp=$msg"
	echo 
    # echo "==`date -Is`: $tit: $msg"  >&2
}
