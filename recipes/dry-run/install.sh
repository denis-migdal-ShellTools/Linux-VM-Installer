upload "script.sh" "/tmp/dry-run"
cmd "cat /tmp/dry-run >> /etc/profile.d/aliases.sh"

cmd "echo 'alias dr=dry-run' >> ~zeus/.bash_aliases"