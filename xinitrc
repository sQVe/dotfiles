
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
xset dpms 300 300 300

# Setup peek cache symlink to tmp.
mkdir /tmp/peek
ln -s /tmp/peek "$HOME/.cache/peek"

# Setup coc yank data symlink to tmp.
mkdir /tmp/coc-yank-data
ln -s /tmp/coc-yank-data "$HOME/.config/coc/extensions/coc-yank-data"

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
