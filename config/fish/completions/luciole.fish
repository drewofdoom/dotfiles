complete -c luciole -f
complete -c luciole -n '__fish_use_subcommand' -a '(__fish_complete_directories (commandline -ct))'
complete -c luciole -n '__fish_use_subcommand' -l help -d 'Show help'
complete -c luciole -n '__fish_use_subcommand' -l version -d 'Show version'
complete -c luciole -n '__fish_use_subcommand' -a completions -d 'Print shell completions'
complete -c luciole -n '__fish_seen_subcommand_from completions' -a 'bash zsh fish'
complete -c luciole -n '__fish_use_subcommand' -a config -d 'Configuration commands'
complete -c luciole -n '__fish_seen_subcommand_from config; and not __fish_seen_subcommand_from validate' -a validate -d 'Validate a TOML file'
complete -c luciole -n '__fish_seen_subcommand_from config; and __fish_seen_subcommand_from validate' -F
