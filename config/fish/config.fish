if status is-interactive
# Commands to run in interactive sessions can go here

    # Use the systemd socket-activated agent (ssh-agent.socket, enabled for this
    # user) instead of spawning an agent per shell. GNOME normally exports
    # SSH_AUTH_SOCK via gnome-keyring's autostart entry, but that entry is gated
    # to OnlyShowIn=GNOME and never fires under Umbriel — and environment.d is
    # read only by systemd units, not by the graphical session, so it cannot set
    # this either. Set it here, guarded so an inherited value is never clobbered.
    if not set -q SSH_AUTH_SOCK; and test -S "$XDG_RUNTIME_DIR/ssh-agent.socket"
        set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
    end

    # ---- Modern replacements for standard tools -------------------------
    # Aliases only, no wrappers: they take effect in interactive shells and
    # leave scripts, pipes and `command foo` calls on the real binaries.

    # ls family -> eza. eza's long view replaces -l; its icons replace --color.
    # NOTE: two quirks in this build (v0.23.5) are worked around here:
    #  1. it prints nothing when given no path, where GNU ls implies `.`;
    #  2. `--icons` takes an optional value, so a trailing path argument gets
    #     swallowed as that value ("invalid value 'x' for '--icons'"). Giving
    #     it an explicit `=auto` and putting paths first avoids both.
    function ls --description 'eza --icons=auto'
        if test (count $argv) -gt 0
            eza --icons=auto $argv
        else
            eza --icons=auto .
        end
    end
    function ll --description 'eza -l --icons=auto --git'
        if test (count $argv) -gt 0
            eza -l --icons=auto --git $argv
        else
            eza -l --icons=auto --git .
        end
    end
    function la --description 'eza -l -a --icons=auto --git'
        if test (count $argv) -gt 0
            eza -l -a --icons=auto --git $argv
        else
            eza -l -a --icons=auto --git .
        end
    end
    function lt --description 'eza --tree --level=2 --icons=auto'
        if test (count $argv) -gt 0
            eza --tree --level=2 --icons=auto $argv
        else
            eza --tree --level=2 --icons=auto .
        end
    end
    function lta --description 'eza --tree --level=2 -a --icons=auto --git'
        if test (count $argv) -gt 0
            eza --tree --level=2 -a --icons=auto --git $argv
        else
            eza --tree --level=2 -a --icons=auto --git .
        end
    end

    # pager -> bat. $PAGER carries bat's own flags; $LESS stays genuine less flags
    # because bat pipes long output through $LESS to its pager, and less would
    # otherwise reject bat-only options like --style=plain.
    set -gx PAGER 'bat --paging=always'
    set -gx LESS '-R -F -X'
    # -p is bat's short form of --style=plain: plain style, no decorations.
    alias cat='bat --paging=always -p'
    alias less='bat --paging=always'

    # grep -> ugrep. -P is not supported, so the recursive and colour defaults
    # are set explicitly rather than inherited.
    alias grep='ugrep --color=auto'
    alias egrep='ugrep --color=auto -E'
    alias fgrep='ugrep --color=auto -F'
    # -r searches the current tree like grep -r; -R also follows symlinks,
    # which is what most people mean interactively.
    alias rgrep='ugrep --color=auto -R'

    # z -> zoxide (frecently-used directories), from homebrew.
    # `zoxide init fish` defines z and zi itself, so source it rather than
    # aliasing z to a subcommand: this version has no `zoxide cd`. Guarded so
    # the shell still starts cleanly if brew is ever unavailable.
    if type -q zoxide
        zoxide init fish | source
    end

    # atuin: shell history with search and sync. Initialised last so it wraps
    # the history commands defined above.
    atuin init fish | source

    fish_add_path -p $HOME/.local/bin $HOME/.cargo/bin

    starship init fish | source
end
