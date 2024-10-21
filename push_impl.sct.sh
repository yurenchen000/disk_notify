
## --------- push via serverChan

sct_sendkey=${sct_sendkey:-'set your sendkey at conf'}

## msg is markdown, new-line need '  \n' OR '\n\n'
do_push_sct(){
    local tit="$1"
    local msg="$2"
    curl "https://sctapi.ftqq.com/$sct_sendkey.send" \
     --data-urlencode "title=$tit" \
     --data-urlencode "desp=$msg"
	echo 
    # echo "==`date -Is`: $tit: $msg"  >&2
}
