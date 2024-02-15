#!/bin/bash

printf "\033[32m
 ▄▄▄▄    ██▓ ██░ ██  ██▓
▓█████▄ ▓██▒▓██░ ██▒▓██▒
▒██▒ ▄██▒██▒▒██▀▀██░▒██▒
▒██░█▀  ░██░░▓█ ░██ ░██░
░▓█  ▀█▓░██░░▓█▒░██▓░██░
░▒▓███▀▒░▓   ▒ ░░▒░▒░▓  
▒░▒   ░  ▒ ░ ▒ ░▒░ ░ ▒ ░
 ░    ░  ▒ ░ ░  ░░ ░ ▒ ░
 ░       ░   ░  ░  ░ ░  
      ░                 
\033[0m\n\n"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

FILES="$SCRIPT_DIR/input_file_txt/*"

read -p "Enter Domain you want to filter (EX : yandex.com Or * for all domain): " DOMAIN_FILTER

read -p "Enter Results file Name: (EX : results_1.txt) :  " RESULT_FILE

RESULT_FILE="$SCRIPT_DIR/$RESULT_FILE"

echo "Filter: $DOMAIN_FILTER" > "$RESULT_FILE"

for f in $FILES
do
  name=$(basename "$f" ".txt")
  echo "Processing $f file... [$name]"

  if [ "$DOMAIN_FILTER" == "*" ]; then
    perl -wne'while(/[\w\.\-]+@[\w\.\-]+\w+/g){print "$&\n"}' "$f" | sort -u > "$name.out"
  else
    perl -wne'while(/[\w\.\-]+@[\w\.\-]+\w+/g){print "$&\n"}' "$f" | grep "$DOMAIN_FILTER" | sort -u > "$name.out"
  fi

  cat "$name.out" >> "$RESULT_FILE" 
done

rm -rf *.out

echo "Processing complete."
