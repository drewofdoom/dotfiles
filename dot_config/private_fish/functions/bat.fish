# ~/.config/fish/functions/bat.fish
# redirect cat to bat

if type -q bat
    function cat
        bat  $argv
    end
end
