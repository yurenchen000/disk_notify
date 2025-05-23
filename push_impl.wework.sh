
## --------- push via feishu bot

## need conf
# WEWORK_BOT_KEY=

## msg is markdown //also support text (via text.content)
do_push_wework(){
    local tit="$1"
    local msg="$2"

	curl -s "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=$WEWORK_BOT_KEY" \
    -H "Content-Type: application/json" \
    -d @- <<-EOF
	{
	  "msgtype": "markdown",
	  "markdown": {
	    "content": "**== $tit ==**  \n$msg"
	  }
	}
	EOF

	echo 
    # echo "==`date -Is`: $tit: $msg"  >&2
}

## note: this file indent need to be tabs, cause bash here-doc
## wework can't send to wechat
## msg formats: https://developer.work.weixin.qq.com/document/path/99110#markdown%E7%B1%BB%E5%9E%8B


