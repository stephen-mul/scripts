#!/bin/bash

ssh-add /home/stephen/.ssh/id_rsa

cd ~/Documents/vault/

git add .
git commit -m 'startup backup'
git push
