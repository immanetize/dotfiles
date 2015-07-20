xsetroot -cursor_name left_ptr
if [ -e ~/.background ]; then 
  background=~/.background
else 
  background=/usr/share/backgrounds/default.png
fi
feh --bg-scale ${background}
  
firefox&
hexchat&
xfce4-terminal&

if [[ ${HOSTNAME} == hermes.home.randomuser.org ]]; then 
  # do hermes-specific things
  echo "stuff" &>/dev/null

  # stop doing hermes-specific things
fi

if [[ ${HOSTNAME} == athena-pete9168.rackspace.corp ]]; then
  # do things just for the work laptop
  evolution &
  xrandr --output eDP1 --primary
  xrandr --output DP1-2 --right-of eDP1
  xrandr --output DP1-1 --right-of DP1-2
  xscreensaver -nosplash
  # stop doing work things
fi  

xmonad


