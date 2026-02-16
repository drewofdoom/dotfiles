# .bashrc.d/cpx.sh

# cpx
# Faster, smarter, better copy

# Requirements:
# cargo - `brew install cargo`
# cpx - `cargo install cpx`

if [ "$(command -v cpx)" ]; then
    alias cp="$HOME/.cargo/bin/cpx"
fi
