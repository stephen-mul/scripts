#!/bin/bash

# Fetch agenda for a single day
gcalcli agenda Monday Tuesday | sed 's/\x1b\[[0-9;]*m//g' | awk '
BEGIN {
    header_printed = 0;
}
{
    # Skip empty lines
    if (NF == 0) next;

    # Capture and print the header with day and date
    if ($1 ~ /^[A-Za-z]+$/ && $2 ~ /^[A-Za-z]+$/ && $3 ~ /^[0-9]{2}$/) {
        if (!header_printed) {
            header = "# Agenda for " $1 ", " $2 " " $3 "\n";
            header_printed = 1;
        }
        next;
    }

    # Print the header once before the first event
    if (header_printed && header != "") {
        print header;
        header = "";
    }

    # Format times and events
    if ($1 ~ /^[0-9]+:/) {
        print "- **" $1 "** " substr($0, index($0, $2));
    } else {
        print $0;
    }
}' > ~/Documents/vault/Personal/daily_agenda.md

echo "Markdown agenda saved to ~/Documents/vault/Personal/daily_agenda.md"