#!/bin/sh


player_status=$(playerctl status 2> /dev/null)

if [ "$player_status" = "Playing" ]; then
    echo "契 $(playerctl metadata -f '{{artist}} - {{title}}')"
elif [ "$player_status" = "Paused" ]; then
    echo " $(playerctl metadata -f '{{artist}} - {{title}}')"
else
    echo "" # needed otherwise polybar won't refresh
fi
