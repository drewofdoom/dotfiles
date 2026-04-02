# ~/.config/fish/config.fish

# Standard Variables
set -U fish_greeting ""
set -gx SHELL /usr/bin/fish
set -U FISH_NO_UPGRADE_WARNING 1
set -Ux EDITOR "/usr/bin/flatpak run org.gnome.TextEditor"
set --global fish_key_bindings fish_default_key_bindings

# Path
if test -d $HOME/.cargo/bin
    fish_add_path -a $HOME/.cargo/bin
end

# Configuration for interactive sessions
if status is-interactive
    # Theme
    fish_config theme choose "Catppuccin Mocha"

    # Completions
    if test -d /home/linuxbrew/.linuxbrew/share/fish/vendor_completions.d
        source /home/linuxbrew/.linuxbrew/share/fish/vendor_completions.d/*.fish
    end

    # Applications
    ## -- Atuin
    if type -q atuin
        eval "$(atuin init fish)"
    end

    ## -- Zoxide
    if type -q zoxide
        eval "$(zoxide init fish)"
    end

    ## -- Bat
    if type -q bat
        function cat
            bat $argv
        end
        set -gx MANPAGER "bat -plman"
    end

    ## -- cpx
    if type -q cpx
        function cp
            cpx $argv
        end
    end

    ## -- eza
    if type -q eza
        function ls
            eza $argv
        end
        function ll
            eza -l --icons=auto --group-directories-first $argv
        end
        function l.
            eza -d .*
        end
        function l1
            eza -1 $argv
        end
    end

    ## -- ugrep
    if type -q ug
        function grep
            ug $argv
        end
        function egrep
            ug -E $argv
        end
        function fgrep
            ug -F $argv
        end
        function xzgrep
            ug -z $argv
        end
        function xzegrep
            ug -zE $argv
        end
        function xzfgrep
            ug -zF $argv
        end
    end

    ## -- GNOME text editor flatpak
    if test -d $HOME/.var/app/org.gnome.TextEditor
        function gedit
            /usr/bin/flatpak run org.gnome.TextEditor $argv
        end
    end

    ## -- VS Code
    if test -d $HOME/.var/app/com.visualstudio.code
        function code
            /usr/bin/flatpak run com.visualstudio.code $argv
        end
    end
end

### Starship prompt
if type -q starship
    starship init fish | source
end

### bling.fish source start
if test -f /usr/share/ublue-os/bling/bling.fish
    source /usr/share/ublue-os/bling/bling.fish
end
### bling.fish source end
