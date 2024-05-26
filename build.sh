#!/usr/bin/env bash
# Call variables script
. scripts/variables
function push() {
# shellcheck disable=SC2154
curl -F document="@$1" "https://api.telegram.org/bot${token}/sendDocument" \
     -F chat_id="${chat_id}"  \
     -F "disable_web_page_preview=true" \
     -F "parse_mode=html"
}
random_number=$((1 + RANDOM % 200))
zip_name=DroidConsole-${VERSION}-${random_number}
echo ""
rm -rf ./*.zip
zip -r9 "$zip_name.zip" . -x "*build*" "*.bak*" "*.git*"
push "$zip_name.zip"