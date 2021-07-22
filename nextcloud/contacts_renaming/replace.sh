#!/bin/bash

INPUT="/var/contacts_renaming/replacements.csv"

while IFS=';' read -r original replacement
do
  sed -i "s/$original/$replacement/g" $1/contacts/l10n/de_DE.json
  sed -i "s/$original/$replacement/g" $1/contacts/l10n/de_DE.js
  sed -i "s/$original/$replacement/g" $1/contacts/l10n/de.json
  sed -i "s/$original/$replacement/g" $1/contacts/l10n/de.js
  echo $original
done < $INPUT