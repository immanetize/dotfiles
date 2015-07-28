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
guake &
nm-applet &
if [[ ${HOSTNAME} == hermes.home.randomuser.org ]]; then 
  # do hermes-specific things
  echo "stuff" &>/dev/null
  stalonetray --geometry 1x1-1340+0 --grow-gravity E -i 24&

  # stop doing hermes-specific things
fi

if [[ ${HOSTNAME} == athena-pete9168.rackspace.corp ]]; then
  # do things just for the work laptop
  evolution &
  fix_work_screens
  xscreensaver -nosplash &
  xinput create-master laptop
  xinput reattach "AlpsPS/2 ALPS DualPoint TouchPad" "laptop pointer"
  # stop doing work things
  stalonetray --geometry 1x1-1340+0 --grow-gravity E -i 24&

fi  

xmonad


