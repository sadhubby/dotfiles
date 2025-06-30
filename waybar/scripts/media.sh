#!/bin/bash

status=$(playerctl status 2> /dev/null)


if ["$status" = "Playing"] || ["$status" = "Paused"]; then
	artist=$(playerctl metadata artist)
	title=$(playerctl metadata title)
	echo "{\"text\": \"$title - $artist\", \"class\": \"$status\"}"
else
	echo ""

fi
