# ~/.config/fish/functions/cpx.fish
# redirect cp to cpx

if type -q cpx
    function cp
        cpx $argv
    end
end
