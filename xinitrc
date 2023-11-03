
#  ╻ ╻╻┏┓╻╻╺┳╸┏━┓┏━╸
#  ┏╋┛┃┃┗┫┃ ┃ ┣┳┛┃
#  ╹ ╹╹╹ ╹╹ ╹ ╹┗╸┗━╸

# Start GPG agent.
gpg-connect-agent updatestartuptty /bye

# Start keyring.
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets)

# Load the Xresources settings.
xrdb "${XDG_CONFIG_HOME}/Xresources"

# Start xiccd colord daemon.
xiccd &

# Setup xorg for dGPU (nvidia) only mode.
if [[ $(envycontrol --query) == "nvidia" ]]; then
  xrandr --setprovideroutputsource modesetting NVIDIA-0
fi

# XSS Lock - handle lid close, suspend etc.
xss-lock -l -- lock &

# Start gesture handling.
libinput-gestures-setup start &

# Set background color.
xsetroot -solid '#282828'

# Set screensaver timer.
xset s 240 0

# Disable DPMS.
xset -dpms

# Start composition manager (xcompmgr).
xcompmgr -c -l 0 -t 0 -r 0 -o 0 &

# Setup ART to use persistent cache.
mkdir -p "${PERSISTENT_CACHE}/ART"
ln -sf "${PERSISTENT_CACHE}/ART" "${XDG_CACHE_HOME}/ART"

# Setup rofi-calc session cache.
mkdir -p "${XDG_DATA_HOME}/rofi"
touch /tmp/rofi_calc_history
ln -sf /tmp/rofi_calc_history "${XDG_DATA_HOME}/rofi/rofi_calc_history"

# Clear playground boxes.
if [[ -d  "${CODE}/playground" ]]; then
  git -C "${CODE}/playground" checkout -- boxes
fi

# Run the scripts in xinitrc.d.
if [[ -d /etc/X11/xinit/xinitrc.d ]]; then
  for file in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [[ -x "${file}" ]] && . "${file}"
  done
  unset f
fi

# Start i3.
exec i3
