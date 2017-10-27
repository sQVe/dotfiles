# Load the Xresources settings.
xrdb ~/.Xresources

# Set background color.
xsetroot -solid "#222222"

# Set screen power timer.
xset dpms 240 240 240

# Start SSH agent.
eval $(ssh-agent)

# Start keyring.
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets)
export SSH_AUTH_SOCK

# Setup peek cache symlink to tmp (solves large file issues as cache is limited to 1G)
ln -s "/tmp" "$HOME/.cache/peek"

# Start xiccd colord daemon.
xiccd &

# Start i3.
exec i3
