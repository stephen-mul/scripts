#!/bin/bash

# Fetch today's agenda
gcalcli agenda Monday Tuesday | awk '
BEGIN {
    # Print Markdown table header
    print "# Agenda for Today\n"
    print "| Time     | Event               |"
    print "|----------|---------------------|"
}
{
    # Skip empty lines
    if (NF == 0) next;

    # Process lines with times and events
    if ($1 ~ /^[0-9]+:/) {
        time = $1;
        event = substr($0, index($0, $2));
        printf "| %-8s | %-20s |\n", time, event;
    }
}' > ~/local_workdir/scratch/daily_agenda.md

echo "Markdown agenda saved to ~/daily_agenda.md"

