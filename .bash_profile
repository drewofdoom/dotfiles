# Bash profile - sourced for login shells
# Includes .bashrc

export PATH="$PATH:/usr/local/bin:/home/drew/.local/bin"

source ~/.bashrc

# Set prompt for non-interactive shells
if [ -z "$PROMPT_COMMAND" ]; then
    PROMPT_COMMAND='history -a; history -w'
fi
