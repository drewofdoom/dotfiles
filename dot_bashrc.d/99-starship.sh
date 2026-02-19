# .bashrc.d/starship.sh

# starship
# fancy prompt

# Requirements:
# bat - `cargo install bat`

if [ "$(command -v starship)" ]; then
    eval "$(starship init bash)"
fi
