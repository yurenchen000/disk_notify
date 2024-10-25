
## --------- push via wxpusher

## need conf
# wxpusher_spt=

## use simple-push
## msg is html //also support 1-text, 2-html, 3-markdown
do_push_wxpusher(){
    local tit="$1"
    local msg="$2"

    curl -s https://wxpusher.zjiecode.com/api/send/message/simple-push \
     -H 'Content-Type: application/json' -d @- <<-EOF
	{
		"content":"$msg",
		"summary":"$tit",
		"contentType":3,
		"spt":"$wxpusher_spt"
	}
	EOF
	echo 
	# echo "==`date -Is`: $tit: $msg"  >&2
}

## note: this file indent need to be tabs, cause bash here-doc
## contentType:1 seems broken with '>'


