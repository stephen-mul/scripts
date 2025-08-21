#!/bin/bash

# Sonraí maidir leis an ríomhaire iargúlta
REMOTE_USER="mulligas"
REMOTE_HOST="login1.baobab.hpc.unige.ch"
REMOTE_DIR="/home/users/m/mulligas/scratch/noisy_scwola"

# Fillteán áitiúil áit a mbeidh tú ag sábháil na gcomhad
LOCAL_DIR="/home/stephen/Pictures/Plots/cwolapp/noisy_scwola"
VAULT_DIR="/home/stephen/Documents/vault/Images"

# Rith an rsync
rsync -avz --progress "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/" "$LOCAL_DIR"

cp -r "${LOCAL_DIR}" "${VAULT_DIR}"
