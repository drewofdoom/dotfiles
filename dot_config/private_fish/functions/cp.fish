# ~/.config/fish/functions/cpx.fish
# redirect cp to cpx

if test -f $HOME/.cargo/bin/cpx
    function cp
        $HOME/.cargo/bin/cpx $argv
    end
end
