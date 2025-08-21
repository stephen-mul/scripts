#/bin/bash

country=$(curl -s ipinfo.io | grep '"country"' | sed 's/.*: "\(.*\)".*/\1/')
echo "you are in: $country"
