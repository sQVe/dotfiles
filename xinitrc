
#  ╻ ╻╻┏┓╻╻╺┳╸┏━┓┏━╸
#  ┏╋┛┃┃┗┫┃ ┃ ┣┳┛┃
#  ╹ ╹╹╹ ╹╹ ╹ ╹┗╸┗━╸

# Start GPG agent.
gpg-connect-agent updatestartuptty /bye

# Start keyring.
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets)

# Load the Xresources settings.
xrdb ~/.Xresources

# Start xiccd colord daemon.
xiccd &

# Start mons daemon.
mons -a &

# Start greenclip daemon.
greenclip daemon &

# XSS Lock - handle lid close, suspend etc.
xss-lock -- lock &

# Start gesture handling.
libinput-gestures-setup start &

# Set background color.
xsetroot -solid '#343434'

# Set initial random wallpaper.
random-wallpaper

# Set screen power timer.
xset dpms 240 240 240

# Setup peek cache symlink to tmp (solves large file issues as cache is limited to 1G).
mkdir /tmp/peek
ln -s /tmp/peek "$HOME/.cache/peek"

# Restore js-playground boxes.
if [[ -d  "$HOME/code/js-playground" ]]; then
  git -C "$HOME/code/js-playground" checkout -- boxes
fi

# Run the scripts in xinitrc.d.
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Start i3.
exec i3
