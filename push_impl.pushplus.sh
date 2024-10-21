
## --------- push via serverChan

## need conf
# pushplush_token=${pushplush_token:-'set your pushplush_token at conf'}
# pushplush_topic=

## msg is markdown, new-line need '  \n' OR '\n\n'
do_push_pushplus(){
    local tit="$1"
    local msg="$2"
    curl -s http://www.pushplus.plus/send \
     -d "token=$pushplush_token" -d "topic=$pushplush_topic" \
     --data-urlencode "title=$tit" \
     --data-urlencode "content=$msg"
	echo 
    # echo "==`date -Is`: $tit: $msg"  >&2
}

