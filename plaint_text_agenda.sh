#!/bin/bash

# Fetch agenda for a single day
current_date_time=$(date +"%Y%m%d_%H%M%S")
gcalcli agenda Monday Tuesday > ~/local_workdir/scratch/daily_agenda_$current_date_time.txt