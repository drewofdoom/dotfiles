### Variables
set -gx SHELL /usr/bin/fish
set -gx FREERDP_PLATFORM "wayland"
set -gx WINELOADER "$HOME/.var/app/com.usebottles.bottles/data/bottles/runners/kron4ek-wine-11.1-staging-tkg-amd64/bin/wine"
set -gx WINEDEBUG "-all"
set -gx WINEFSYNC "1"
set -gx MANPAGER "bat -plman"

### Path
if test -d $HOME/.cargo/bin
    fish_add_path -a $HOME/.cargo/bin
end

### If in interactive session
if status is-interactive
    atuin init fish | source
    fish_config theme choose "Catppuccin Mocha"
end

### bling.fish source start
test -f /usr/share/ublue-os/bling/bling.fish && source /usr/share/ublue-os/bling/bling.fish
### bling.fish source end
