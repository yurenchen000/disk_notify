
## --------- push via telegram bot

## need conf
# TELEGRAM_BOT_TOKEN=
# TELEGRAM_CHAT_ID=
# TELEGRAM_PROXY=  ## use http/socks proxy

## msg is markdown //also support markdown,markdownv2,html  or text if omit
do_push_telegram(){
    local tit="$1"
    local msg="$2"

    # msg=
    https_proxy="$TELEGRAM_PROXY" curl -s "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
     -d chat_id="$TELEGRAM_CHAT_ID" \
     -d text="*== $tit ==*"$'\n'"$msg" \
     -d parse_mode=markdown

	echo 
    # echo "==`date -Is`: $tit: $msg"  >&2
}

## omit is text
## markdown is easy, but limited formats
## markdownv2 need more escape (by preceding \) : _ * [] () {} ~ ` > # +-= |  . ! 
## msg formats: https://core.telegram.org/bots/api#formatting-options


