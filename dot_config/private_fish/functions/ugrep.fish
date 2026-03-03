# ~/.config/fish/functions/ugrep.fish
# redirect grep to ugrep

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
