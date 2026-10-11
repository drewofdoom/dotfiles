# Drewofdoom's Dotfiles

Simple dotfiles management.

No need for tools like chezmoi that require you to modify the files in the repo, then redeploy them every time. Everything is a simple symlink.

Watch out for merge conflicts if you often use multiple machines. This is pretty perfect for when you operate a single machine normally, then have a laptop or similar that you use less often.

Designed for use with ublue systems that already have brew installed. Will fail without brew and flatpak.

Obviously, these are personal dotfiles. If you're reading this and you are not me, don't just install this stuff. Cherry pick what you want from my dotfiles and adapt them for your own.

## Requirements

### Proton Pass

Install Proton's pass-cli, login, set up ssh-agent

```
brew install protonpass/tap/pass-cli
pass-cli login
pass-cli ssh-agent daemon start --socket-path /run/user/1000/ssh-agent.socket
pass-cli ssh-agent load
```

### Ansible

Install ansible via pip. Don't install it through homebrew, as it will cause issues with ansible lint not being able to find installed collections:

```
pip install --user ansible ansible-lint ansible-navigator
ansible-galaxy collection install community.general
```

## Installation

Clone the repo

```
mkdir -p ~/Projects
git clone https://github.com/drewofdoom/dotfiles
```

Run the playbook

```
cd dotfiles
ansible-galaxy playbook dotfiles.playbook.yml
```

It automatically links everything (forced, so it will overwrite files that already exist by design) to wherever you pulled this repo to. Suggested to put it into `~/Projects` with the rest of your git projects.

## Post-deployment steps

Enable pass-cli ssh-agent daemon systemd user service. Not that the previous daemon will still be running, so you don't really want to clobber it with a `--now` at the moment.

```
systemctl --user daemon-reload
systemctl --user enable proton-pass-ssh-agent.service
```

Log into atuin for sync

```
atuin login
```

Log into GitHub with gh

```
gh auth login
```

Update tldr (swap to `tldr --update` when brew ships a fixed bottle)

```
tldr-update
```
