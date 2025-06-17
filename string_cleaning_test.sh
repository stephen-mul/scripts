#!/bin/bash

# Fetch the agenda for Monday and Tuesday, stripping ANSI codes, echo each line to agenda.md file
gcalcli agenda Monday Tuesday | sed -e 's/\x1b\[[0-9;]*m//g' | 
while read i
do
    echo $i >> ~/Documents/vault/agenda.md
done

echo "Markdown agenda saved to ~/agenda.md"