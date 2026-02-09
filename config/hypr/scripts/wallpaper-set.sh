#!/usr/bin/env bash

awww-daemon & disown

WALLPAPER="$HOME/Pictures/Wallpapers/backiee-217832-landscape.jpg"

awww img "$WALLPAPER" --resize fit -t none
