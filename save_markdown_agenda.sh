#!/bin/bash

# Fetch today's agenda
gcalcli agenda today today | awk '
BEGIN {
    print "# Agenda for Today\n"
}
{
    # Skip empty lines
    if (NF == 0) next;

    # Format times and events
    if ($1 ~ /^[0-9]+:/) {
        print "- **" $1 "** " substr($0, index($0, $2));
    } else {
        print $0;
    }
}' > ~/local_workdir/scratch/daily_agenda.md

echo "Markdown agenda saved to ~/daily_agenda.md"

