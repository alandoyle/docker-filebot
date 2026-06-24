#!/bin/sh

if [ "$VNC_PASSWORD" ]; then
    sed -i "s/^\(command.*x11vnc.*\)$/\1 -passwd '$VNC_PASSWORD'/" /etc/supervisord.conf
fi

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

# Add "Media" bookmark
[ ! -d ~/.config/gtk-3.0 ] && mkdir -p  ~/.config/gtk-3.0
[ ! -f ~/.config/gtk-3.0/bookmarks ] && echo "file:///media Media" > ~/.config/gtk-3.0/bookmarks

# Start the applications
/usr/bin/supervisord