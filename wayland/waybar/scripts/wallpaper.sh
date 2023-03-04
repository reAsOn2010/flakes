#!/usr/bin/env bash
mkdir -p $HOME/.config/wallpapers
for ((i=0; i < 10; i++))
do
	curl -Lo $HOME/.config/wallpapers/wallpaper$i.jpg https://source.unsplash.com/1920x1080/?city,night,ocean,space
done

