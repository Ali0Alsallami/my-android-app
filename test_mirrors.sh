#!/bin/bash

mirrors=(
  "https://gnlug.org/pub/termux/termux-main"
  "https://mirror.mwt.me/termux/termux-main"
  "https://termux.librehat.com/termux-main"
  "https://mirror.bardia.tech/termux/termux-main"
)

fastest_mirror=""
fastest_speed=0

echo "اختبار سرعة المرايا..."
for mirror in "${mirrors[@]}"; do
  speed=$(curl -o /dev/null -w "%{speed_download}" -s "$mirror/dists/stable/InRelease")
  echo "المرآة: $mirror - السرعة: $speed بايت/ثانية"
  if (( $(echo "$speed > $fastest_speed" | bc -l) )); then
    fastest_mirror=$mirror
    fastest_speed=$speed
  fi
done

echo "المرآة الأسرع: $fastest_mirror بسرعة $fastest_speed بايت/ثانية"
echo "deb $fastest_mirror stable main" > "$HOME/sources.list"
