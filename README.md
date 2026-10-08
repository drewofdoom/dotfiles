# Drewofdoom's Dotfiles

Simple dotfiles management.

No need for tools like chezmoi that require you to modify the files in the repo, then redeploy them every time. Everything is a simple symlink.

Watch out for merge conflicts if you often use multiple machines. This is pretty perfect for when you operate a single machine normally, then have a laptop or similar that you use less often.

Designed for use with ublue systems that already have brew installed. Will fail without brew and flatpak.

Obviously, these are personal dotfiles. If you're reading this and you are not me, don't just install this stuff. Cherry pick what you want from my dotfiles and adapt them for your own.

## Installation

Install ansible via pip. Don't install it through homebrew, as it will cause issues with ansible lint not being able to find installed collections.

`pip install --user ansible ansible-lint ansible-navigator`

Then just run the playbook:

`ansible-galaxy playbook dotfiles.playbook.yml`

It automatically links everything (forced, so it will overwrite files that already exist by design) to wherever you pulled this repo to. Suggested to put it into `~/Projects` with the rest of your git projects.
