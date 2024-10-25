
## --------- push via feishu bot

## need conf
# FEISHU_BOT_TOKEN=

## msg is text //also support rich post, no markdown support
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
## text: msg_type: 'text'  // easy to use
## rich: msg_type: 'post'  // use nested json obj
## msg formats: https://open.feishu.cn/document/client-docs/bot-v3/add-custom-bot#1b70f1fa


