# .bashrc.d/bat.sh

# bat
# better cat

# Requirements:
# bat - `cargo install bat`

if [ "$(command -v bat)" ]; then
    alias cat=bat
    export MANPAGER="bat -plman"
fi
