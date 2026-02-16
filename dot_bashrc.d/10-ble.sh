# .bashrc.d/10-ble.sh

# BASH replacement for readline

# Requirements:
# ble.sh - https://github.com/akinomyoga/ble.sh

if [ -f $HOME/.local/share/blesh/ble.sh ]; then
    source -- $HOME/.local/share/blesh/ble.sh
fi
