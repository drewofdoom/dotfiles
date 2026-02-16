# .bashrc.d/11-atuin.sh

# Synced history replacement
# Does not rely on BLE, but is enhanced with its readline functions

# atuin - `brew install atuin`
if [ "$(command -v atuin)" ]; then
    eval "$(atuin init bash)"
fi
