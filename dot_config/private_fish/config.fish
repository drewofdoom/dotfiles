# ~/.config/fish/config.fish

# Standard Variables
set -U fish_greeting ""
set -gx SHELL /usr/bin/fish

# Path
if test -d $HOME/.cargo/bin
    fish_add_path -a $HOME/.cargo/bin
end

# Configuration for interactive sessions
if status is-interactive
    # Applications
    ## -- Atuin
    if type -q atuin
        eval "$(atuin init fish)"
    end
    ## -- Bat
    if type -q bat
        set -gx MANPAGER "bat -plman"
    end
    ## -- Zoxide
    if type -q zoxide
        eval "$(zoxide init fish)"
    end

    # Theme
    fish_config theme choose "Catppuccin Mocha"
end

### bling.fish source start
# test -f /usr/share/bazzite-cli/bling.fish && source /usr/share/bazzite-cli/bling.fish
### bling.fish source end

### Starship prompt
if type -q starship;
    starship init fish | source
end
