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

if [[ ${HOSTNAME} == athena ]]; then
  # do things just for the work laptop
  evolution &

  # stop doing work things
fi  

xmonad


