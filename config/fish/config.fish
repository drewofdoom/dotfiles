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
        eza --icons=auto $argv .
    end
    function ll --description 'eza -l --icons=auto --git'
        eza -l --icons=auto --git $argv .
    end
    function la --description 'eza -l -a --icons=auto --git'
        eza -l -a --icons=auto --git $argv .
    end
    function lt --description 'eza --tree --level=2 --icons=auto'
        eza --tree --level=2 --icons=auto $argv .
    end
    function lta --description 'eza --tree --level=2 -a --icons=auto --git'
        eza --tree --level=2 -a --icons=auto --git $argv .
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

    # tldr: the brew build's own `tldr --update` fails to fetch
    # (its linked libcurl 8.22 rejects the codeload redirect), but lookups work
    # fine against pages installed under ~/.tldrc/tldr. Update via curl+unzip
    # instead. Note `--clear-cache` deletes that pages directory outright, so
    # never call it after installing. Drop this once brew ships a fixed bottle.
    function tldr-update --description 'refresh tldr pages (works around brew build)'
        set -l tmp (mktemp -d)
        curl -sL -o $tmp/tldr.zip https://github.com/tldr-pages/tldr/archive/main.zip || return 1
        unzip -q $tmp/tldr.zip -d $tmp || return 1
        mkdir -p ~/.tldrc/tldr
        rm -rf ~/.tldrc/tldr/pages
        cp -r $tmp/tldr-main/pages ~/.tldrc/tldr/
        cp $tmp/tldr-main/LICENSE.md ~/.tldrc/tldr/ 2>/dev/null
        rm -rf $tmp
        echo "tldr pages updated"
    end
end

starship init fish | source