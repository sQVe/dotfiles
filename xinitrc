
#  ╻ ╻╻┏┓╻╻╺┳╸┏━┓┏━╸
#  ┏╋┛┃┃┗┫┃ ┃ ┣┳┛┃
#  ╹ ╹╹╹ ╹╹ ╹ ╹┗╸┗━╸

# Start GPG agent.
gpg-connect-agent updatestartuptty /bye

# Start keyring.
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets)

# Load the Xresources settings.
xrdb "$XDG_CONFIG_HOME/Xresources"

# Start xiccd colord daemon.
xiccd &

# Start mons daemon.
mons -a &

# XSS Lock - handle lid close, suspend etc.
xss-lock -l -- lock &

# Start gesture handling.
libinput-gestures-setup start &

# Set background color.
xsetroot -solid '#282828'

# Set screen power timer.
xset s 210 210
xset dpms 240 240 240

# Start composition manager (xcompmgr).
xcompmgr -c -l 0 -t 0 -r 0 -o 0 &

# Setup peek cache symlink to tmp.
mkdir /tmp/peek
ln -sf /tmp/peek "$XDG_CACHE_HOME/peek"

# Setup rofi-calc to only save history per session.
touch /tmp/rofi_calc_history
mkdir "$XDG_DATA_HOME/rofi"
ln -sf /tmp/rofi_calc_history "$XDG_DATA_HOME/rofi/rofi_calc_history"

# Clear notes.
if [[ -d  "$NOTES" ]]; then
  git -C "$NOTES" checkout -- .
fi

# Clear playground boxes.
if [[ -d  "$CODE/playground" ]]; then
  git -C "$CODE/playground" checkout -- boxes
fi

# Run the scripts in xinitrc.d.
if [[ -d /etc/X11/xinit/xinitrc.d ]]; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [[ -x "$f" ]] && . "$f"
  done
  unset f
fi

# Start i3.
exec i3
