#!/bin/bash

# Optionally start blutooth
if [[ "$1" == "--bt" ]]; then
  echo "starting Bluetooth daemon..."
  sudo systemctl start bluetooth
fi

# Run agenda construction.sh with a timeout of 30 seconds
timeout 30s bash /home/stephen/local_workdir/personal/agenda_construction/agenda_construction.sh
if [[ $? -eq 124 ]]; then
  echo "agenda_construction.sh timed out after 30 seconds."
fi

# set up ssh
ssh-add /home/stephen/.ssh/id_rsa

bash /home/stephen/local_workdir/personal/scripts/push-vault.sh
flatpak run org.mozilla.firefox &
flatpak run md.obsidian.Obsidian &
zotero &
