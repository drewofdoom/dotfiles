# ~/.config/fish/functions/zed.fish
# zed shortcut for flatpak zed editor

if test -d $HOME/.var/app/dev.zed.Zed
    function zed
        /usr/bin/flatpak run dev.zed.Zed $argv
    end
end
