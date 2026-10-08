# Drewofdoom's Dotfiles

This repository contains dotfiles for managing the host environment, organized by location rather than category for direct deployment.

## Structure

### Shell Configurations
- `.bashrc` - Bash user configuration
- `.bash_profile` - Bash login shell configuration  
- `.zshrc` - Zsh user configuration
- `.profile` - Generic profile configuration

### GUI Configurations
- `.config/umbriel/config.toml` - Umbriel compositor settings
- `.config/gtk-3.0/settings.ini` - GTK theme settings

### System Configurations
- `.ssh/config` - SSH client configuration

### Custom Tools
- `.local/bin/my-tool` - Sample custom tool (executable)

## Deployment

Use Ansible for deployment:

```bash
ansible-playbook ansible/playbooks/deploy-dotfiles.yml -t shell
git add .
git commit -m "Initial dotfiles scaffold"
```

Tags available:
- `shell` - Shell configurations
- `gui` - GUI configurations  
- `system` - System configurations
- `tools` - Custom tools

## Usage

The files contain example content suitable for an Atomic Fedora/Bluefin workstation with:
- Shell prompt customization
- GTK/Nord theme integration
- SSH configuration
- Custom tool scaffolding

## Notes

- All files maintain leading dots for direct location mapping
- No symlinks are created in this repository - ansible creates them during deployment
- Structure allows selective deployment via tags
