#!/bin/zsh
WORD=("上野" "渋谷" "新宿" "恵比寿")
for i in $WORD; do
echo -n "$i-"
if curl -sGN "https://www.geocoding.jp/?q=$i" | grep -o "該当する住所が見つかりませんでした。"; then
elif curl -sGN "https://www.geocoding.jp/?q=$i" | grep -o "Too Many Requests. Wait 6 hours."; then
    echo "怒られたのでしばらく経ってから実行してください。"
    break
else
    curl -sGN "https://www.geocoding.jp/?q=$i"|
    grep "var latlng = new Y.LatLng(.*, .*);"|
    sed -e 's|var latlng = new Y.LatLng(||g' -e 's|);||g'
fi
sleep 3s
done
