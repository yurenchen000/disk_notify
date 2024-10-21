
## --------- push via serverChan

send_key=${send_key:-'set your sendkey at conf'}

## msg is markdown, new-line need '  \n' OR '\n\n'
do_push_sct(){
    local tit="$1"
    local msg="$2"
    curl "https://sctapi.ftqq.com/$send_key.send" \
     --data-urlencode "title=$tit" \
     --data-urlencode "desp=$msg"
	echo 
    # echo "==`date -Is`: $tit: $msg"  >&2
}
