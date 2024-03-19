#!/usr/bin/env bash
function push() {
# shellcheck disable=SC2154
curl -F document="@$1" "https://api.telegram.org/bot${token}/sendDocument" \
     -F chat_id="${chat_id}"  \
     -F "disable_web_page_preview=true" \
     -F "parse_mode=html"
}
echo ""
rm -rf ./*.zip
zip -r9 "DroidConsole-BETA-2.zip" . -x "*build*" "*.bak*" "*.git*"
push "DroidConsole-BETA-2.zip"