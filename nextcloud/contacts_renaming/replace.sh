#!/bin/bash

INPUT = replacements.csv

while IFS=; read -r original replacement
do
  sed -i "s/$original/$replacement/g" /var/www/html/custom_apps/contacts/l10n/de_DE.json
done < $INPUT