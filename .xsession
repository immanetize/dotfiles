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
stalonetray&
guake &
nm-applet &
if [[ ${HOSTNAME} == hermes.home.randomuser.org ]]; then 
  # do hermes-specific things
  echo "stuff" &>/dev/null

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

fi  

xmonad


