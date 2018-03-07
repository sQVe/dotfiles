# Start SSH agent.
eval $(ssh-agent)

# Start keyring.
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets)
export SSH_AUTH_SOCK

# Load the Xresources settings.
xrdb ~/.Xresources

# Start xiccd colord daemon.
xiccd &

# Start mons daemon.
mons -a &

# Start URxvt daemon.
urxvtd -q -f -o &

# Start clipit.
clipit &

# XSS Lock - handle lid close, suspend etc.
xss-lock -- lock &

# Start gesture handling.
libinput-gestures-setup start &

# Set background color.
xsetroot -solid "#343434"

# Set initial wallpaper.
$HOME/scripts/random-wall.sh

# Set screen power timer.
xset dpms 240 240 240

# Setup peek cache symlink to tmp (solves large file issues as cache is limited to 1G).
ln -s "/tmp" "$HOME/.cache/peek"

# Run the scripts in xinitrc.d.
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Start i3.
exec i3
