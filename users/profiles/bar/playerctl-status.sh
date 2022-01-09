#!/bin/sh


# if nothing is playing, just exit
# if a player is playing, get that player's name
# stops players that are stopped (not paused) such as browsers showing up when you have another player that is actually playing
# TODO: intergrate this functionality with sxhkd and buttons in polybar
player=`playerctl metadata -f "{{playerName}}" 2> /dev/null`


player_status=$(playerctl -p $player status 2> /dev/null)

if [ "$player_status" = "Playing" ]; then
    echo "契 $(playerctl -p $player metadata -f '{{artist}} - {{title}}')"
elif [ "$player_status" = "Paused" ]; then
    echo " $(playerctl -p $player metadata -f '{{artist}} - {{title}}')"
else
    echo "" # needed otherwise polybar won't refresh
fi
