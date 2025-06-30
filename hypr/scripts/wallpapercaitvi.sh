#!/bin/bash

# === Configuration ===
WALLPAPER1="/home/moonberry/Pictures/wallpapers/caitvistart.png"
WALLPAPER2="/home/moonberry/Pictures/wallpapers/caitviend.png"
TRANSITION_VIDEO="/home/moonberry/Videos/caitvi4k.mp4"
CURRENT_FILE="/tmp/current_wallpaper.txt"
VIDEO_DURATION=96
MONITOR="eDP-1"
RESOLUTION="2880x1800"

# === Ensure swww is initialized ===
swww query || swww init

# === Read current wallpaper state ===
[ ! -f "$CURRENT_FILE" ] && echo "1" >"$CURRENT_FILE"
CURRENT=$(cat "$CURRENT_FILE")

# === Kill existing instances ===
pkill -f "mpvpaper.*$MONITOR"

# === Optimized mpvpaper command ===
mpvpaper "$MONITOR" -o "
    --loop-file=no
    --hwdec=auto-copy-safe  # Safer hardware decoding
    --vd-lavc-threads=4     # Better CPU decoding
    --profile=sw-fast
    --video-sync=display-resample
    --interpolation
    --scale=lanczos
    --cscale=lanczos
    --dscale=lanczos
    --tscale=oversample
    --video-zoom=0
    --panscan=1.0
    --video-aspect-override=16:10
    --vf=format=yuv420p,scale=2880:1800:flags=lanczos
    --gpu-context=wayland
    --opengl-pbo
    --sws-scaler=lanczos
    --fbo-format=rgba16f
    " "$TRANSITION_VIDEO" &
PID=$!

# === Wallpaper transition ===
if [ "$CURRENT" = "1" ]; then
  sleep 0.5
  swww img "$WALLPAPER2" --transition-type=fade --transition-fps=60 --transition-duration=2
  echo "2" >"$CURRENT_FILE"
else
  sleep 0.5
  swww img "$WALLPAPER1" --transition-type=fade --transition-fps=60 --transition-duration=2
  echo "1" >"$CURRENT_FILE"
fi

# === Timer ===
sleep "$VIDEO_DURATION"

# === Cleanup ===
pkill -f "mpvpaper.*$MONITOR"
if [ "$CURRENT" = "1" ]; then
  swww img "$WALLPAPER2" --transition-type=fade
else
  swww img "$WALLPAPER1" --transition-type=fade
fi
