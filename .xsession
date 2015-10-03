xsetroot -cursor_name left_ptr
if [ -e ~/.background ]; then 
  background=~/.background
else 
  background=/usr/share/backgrounds/default.png
fi
feh --bg-scale ${background}

firefox&
xfce4-terminal&
guake &
nm-applet &
if [[ ${HOSTNAME} == ruminant.randomuser.org ]]; then 
#  xrandr --output DVI-I-1-1 --left-of HDMI4
#  xrandr --output DVI-I-1-1 --auto
  echo "stuff"
fi
if [[ ${HOSTNAME} == hermes.home.randomuser.org ]]; then 
  # do hermes-specific things
  echo "stuff" &>/dev/null
  stalonetray --geometry 1x1-1340+0 --grow-gravity E -i 24&

  # stop doing hermes-specific things
fi

if [[ ${HOSTNAME} == athena-pete9168.rackspace.corp ]]; then
  # do things just for the work laptop
  ssh -f util.randomuser.org -L7778:util.randomuser.org:7778 -N
  evolution &
  fix_work_screens
  xscreensaver -nosplash &
  xinput create-master laptop
  xinput reattach "AlpsPS/2 ALPS DualPoint TouchPad" "laptop pointer"
  # stop doing work things
  stalonetray --geometry 1x1-1340+0 --grow-gravity E -i 24&
  pidgin

fi  

hexchat&
xmonad


