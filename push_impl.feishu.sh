
## --------- push via feishu bot

## need conf
# FEISHU_BOT_TOKEN=

## msg is text //also support markdown,markdownv2,html
do_push_feishu(){
    local tit="$1"
    local msg="$2"

    curl -s https://open.feishu.cn/open-apis/bot/v2/hook/$FEISHU_BOT_TOKEN \
    -H "Content-Type: application/json" \
    -d @- <<-EOF
	{"msg_type":"text","content":{"text":"== $tit ==\n$msg"}}
	EOF

	echo 
    # echo "==`date -Is`: $tit: $msg"  >&2
}

## note: this file indent need to be tabs, cause bash here-doc

