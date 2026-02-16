# .bashrc.d/zed.sh

# Zed
# Rust-based graphical text editor
# Simple alias to easily launch the flatpak

# Requirements:
# Zed - `flatpak install flathub dev.zed.Zed`

if [ -d $HOME/.var/app/dev.zed.Zed ]; then
    alias zed="flatpak run dev.zed.Zed"
fi
