#!/bin/bash

# Fetch the agenda for Monday and Tuesday, stripping ANSI codes
gcalcli agenda Monday Tuesday | sed -e 's/\x1b\[[0-9;]*m//g' | awk '
BEGIN {
    # Print Markdown table header
    print "# Agenda for Monday and Tuesday\n"
    print "| Time     | Event                         |"
    print "|----------|-------------------------------|"
}

# Handle lines with day and date (e.g., "Mon Dec 02")
/^[A-Za-z]{3} [A-Za-z]{3} [0-9]{2}/ {
    current_date = $0;
    print "\n## " current_date "\n";
    next;
}

# Handle lines with events
/^[0-9]+:/ {
    time = $1;                          # Extract time
    event = substr($0, index($0, $3));  # Extract event description
    printf "| %-8s | %-30s |\n", time, event;
    next;
}

# Handle continuation lines (indented lines for multi-line descriptions)
{
    if (current_date != "" && time != "") {
        # Append continuation text to the last event row
        event = substr($0, 1);  # Take the entire line as additional description
        printf "| %-8s | %-30s |\n", "", event;
    }
}' > ~/agenda_markdown.md
### echo the cleaned agenda to the terminal
cat ~/agenda_markdown.md

echo "Markdown agenda saved to ~/agenda_markdown.md"

