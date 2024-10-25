
## --------- push via feishu bot

## need conf
# DINGTALK_BOT_TOKEN=

## msg is markdown //also support text (via content)
do_push_dingtalk(){
    local tit="$1"
    local msg="$2"

    curl -s "https://oapi.dingtalk.com/robot/send?access_token=$DINGTALK_BOT_TOKEN" \
    -H "Content-Type: application/json" \
    -d @- <<-EOF
	{
	  "msgtype": "markdown",
	  "markdown": {
	    "title": "$tit",
	    "text": "**== $tit ==**  \n$msg"
	  }
	}
	EOF

	echo 
    # echo "==`date -Is`: $tit: $msg"  >&2
}

## note: this file indent need to be tabs, cause bash here-doc
## msg formats: https://open.dingtalk.com/document/orgapp/custom-bot-send-message-type#66407430cd5xr

