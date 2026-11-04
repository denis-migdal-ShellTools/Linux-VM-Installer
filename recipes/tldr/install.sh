#!/usr/bin/bash

cmd "pipx install pipx"
cmd "apt purge -y --autoremove pipx"
cmd "/root/.local/bin/pipx install --global pipx"
cmd "hash -r"
cmd "pipx install --global tldr"

# cache (> 100 years)
cmd "echo 'TLDR_CACHE_MAX_AGE=1000000' >> /etc/environment"
cmd "mkdir /usr/local/share/tldr"
cmd "mkdir /home/zeus/.cache"
cmd "chown -R zeus:zeus /home/zeus/.cache"
cmd "ln -s /usr/local/share/tldr /home/zeus/.cache/tldr"
cmd "ln -s /usr/local/share/tldr /root/.cache/tldr"
cmd "tldr -u"