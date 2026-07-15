# ~/.config/fish/config.fish

# Standard Variables
set -U fish_greeting ""
set -gx SHELL /usr/bin/fish
set -U FISH_NO_UPGRADE_WARNING 1
set --global fish_key_bindings fish_default_key_bindings

# Configuration for interactive sessions
if status is-interactive
  # Theme
  fish_config theme choose "Rosé Pine Auto"

  # Prompt
  if type -q starship
    starship init fish | source
  end

  # Path
  ## -- Rust
  if test -d $HOME/.cargo/bin
    fish_add_path -a $HOME/.cargo/bin
  end

  ## -- linuxbrew
  if test -d /home/linuxbrew/.linuxbrew/bin
    fish_add_path -a /home/linuxbrew/.linuxbrew/bin
  end

  # Completions
  if test -d /home/linuxbrew/.linuxbrew/share/fish/vendor_completions.d
    source /home/linuxbrew/.linuxbrew/share/fish/vendor_completions.d/*.fish
  end

  ## -- Atuin
  if type -q atuin
    eval "$(atuin init fish --disable-up-arrow)"
  end

  ## -- Zoxide
  if type -q zoxide
    zoxide init fish --cmd cd | source
  end

  ## -- dust
  if type -q dust
    function du
      dust $argv
    end
  end

  ## -- Bat
  if type -q bat
    function cat
      bat --plain $argv
    end
    set -gx MANPAGER "bat -plman"
  end

  ## -- eza
  if type -q eza
    set -gx EZA_CONFIG_DIR ~/.config/eza
    function ls
      eza $argv
    end
    function ll
      eza -l --icons=auto --group-directories-first $argv
    end
    function l.
      eza -d .*
    end
    function l1
      eza -1 $argv
    end
  end

  # -- fd
  if type -q fd
    function find
      fd $argv
    end
  end

  ## -- ripgrep
  if type -q rg
    function grep
      rg $argv
    end
    function egrep
      rg -e $argv
    end
    function fgrep
      rg -F $argv
    end
    function xzgrep
      rg -z $argv
    end
    function xzegrep
      rg -ze $argv
    end
    function xzfgrep
      rg -zF $argv
    end
  end
end
