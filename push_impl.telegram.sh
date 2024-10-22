
## --------- push via telegram bot

## need conf
# TELEGRAM_BOT_TOKEN=
# TELEGRAM_CHAT_ID=

## msg is text //also support markdown,markdownv2,html
do_push_telegram(){
    local tit="$1"
    local msg="$2"

    curl -s "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
     -d chat_id="$TELEGRAM_CHAT_ID" \
     -d text="== $tit =="$'\n'"$msg"

	echo 
    # echo "==`date -Is`: $tit: $msg"  >&2
}

