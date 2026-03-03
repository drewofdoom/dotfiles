# ~/.config/fish/functions/eza.fish
# redirect ls to eza

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
