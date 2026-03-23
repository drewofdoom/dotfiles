# ~/.config/fish/config.fish

# Standard Variables
set -U fish_greeting ""
set -gx SHELL /usr/bin/fish
set -U FISH_NO_UPGRADE_WARNING 1

# Path
if test -d $HOME/.cargo/bin
    fish_add_path -a $HOME/.cargo/bin
end

# Configuration for interactive sessions
if status is-interactive
    # Applications
    ## Eval
    ### -- Atuin
    if type -q atuin
        eval "$(atuin init fish)"
    end

    ### -- Zoxide
    if type -q zoxide
        eval "$(zoxide init fish)"
    end

    ## Conditional replacements
    ### -- Bat
    if type -q bat
        function cat
            bat  $argv
        end
        set -gx MANPAGER "bat -plman"
    end

    ### -- cpx
    if type -q cpx
        function cp
            cpx $argv
        end
    end

    ### -- eza
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

    ### -- ugrep
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

    ### -- zed flatpak
    function zed
        /usr/bin/flatpak run dev.zed.Zed $argv
    end
    
    ### -- GNOME text editor flatpak
    function edit
        /usr/bine/flatpak run org.gnome.TextEditor $argv
    end

    # Theme
    fish_config theme choose "Catppuccin Mocha"
end

### Starship prompt
if type -q starship;
    starship init fish | source
end
