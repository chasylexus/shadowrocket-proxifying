#!/bin/sh
set -eu

status=0

check_url() {
    url="$1"
    code="$(curl -L -s -o /dev/null -w '%{http_code}' "$url")"
    printf '%s %s\n' "$code" "$url"
    [ "$code" = 200 ] || status=1
}

repo_raw="https://raw.githubusercontent.com/chasylexus/shadowrocket-proxifying/refs/heads/main"
bm7="https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/refs/heads/master/rule/Shadowrocket"

for file in \
    shadowrocket.ruleset.direct.list \
    shadowrocket.ruleset.proxy-a.list \
    shadowrocket.ruleset.proxy-t-priority.list \
    shadowrocket.ruleset.proxy-t.list \
    shadowrocket.ruleset.proxy-t-ip.list \
    shadowrocket.ruleset.proxy-t-late.list
do
    check_url "$repo_raw/$file"
done

for name in \
    Netflix Hulu Disney HBO PrimeVideo Advertising Gemini YouTube Spotify LastFM \
    Facebook Instagram Twitter Telegram TelegramNL TelegramSG TelegramUS \
    TikTok Discord LinkedIn Microsoft Google Wikipedia Amazon
do
    check_url "$bm7/$name/$name.list"
done

check_url "https://raw.githubusercontent.com/itdoginfo/allow-domains/refs/heads/main/Services/google_ai.lst"
check_url "https://raw.githubusercontent.com/itdoginfo/allow-domains/refs/heads/main/Services/hdrezka.lst"
check_url "https://raw.githubusercontent.com/Ja7ad/ShadowRocket/main/rules/reject/adguards.list"
check_url "https://raw.githubusercontent.com/Ja7ad/ShadowRocket/main/rules/reject/apple.list"
check_url "https://raw.githubusercontent.com/Ja7ad/ShadowRocket/main/rules/reject/spotify.list"

exit "$status"
