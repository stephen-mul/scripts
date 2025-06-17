#!/bin/bash

text_with_ansi="This is an example [0;33mtext with color[0m"
clean_text=$(echo -e "$text_with_ansi" | perl -pe '\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])')
echo "$clean_text"