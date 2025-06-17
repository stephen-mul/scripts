#!/bin/bash

# Check if sufficient arguments are provided
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <URL> <search-term>"
  exit 1
fi

# Assign arguments to variables
URL="$1"
SEARCH_TERM="$2"
TIMEOUT=10  # Timeout duration in seconds

# Fetch the webpage with a timeout and process the content
CONTENT=$(curl -s --max-time "$TIMEOUT" "$URL")
if [ $? -eq 28 ]; then
  echo "Request to $URL timed out after $TIMEOUT seconds"
  exit 1
fi

# Search for the term in paragraphs and highlight it
PARAGRAPH=$(echo "$CONTENT" | grep -i -o -P "(?:<p[^>]*>.*?${SEARCH_TERM}.*?</p>)" | head -n 1)

if [ -n "$PARAGRAPH" ]; then
  # Highlight the search term (case-insensitive)
  HIGHLIGHTED=$(echo "$PARAGRAPH" | sed -E "s/(${SEARCH_TERM})/\\033[1;31m\1\\033[0m/Ig")
  echo -e "Term '$SEARCH_TERM' found in the following paragraph:\n$HIGHLIGHTED"
else
  echo "Term '$SEARCH_TERM' not found on $URL"
fi

