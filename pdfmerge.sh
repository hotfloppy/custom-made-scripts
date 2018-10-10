#!/usr/bin/env bash

PATHNAME=$(dirname $(readlink -f $0))
source ${PATHNAME}/config

pdftk_installed=$(dpkg -l | grep pdftk | wc -l)
if [[ "$pdftk_installed" -lt 1 ]]; then
  echo -e ${red}"PDFTk not installed. Abort operation."${nc}
  exit 99
fi

gotpdf=$(ls *.pdf | grep -v mergedpdf- | wc -l)
if [ "$gotpdf" -eq 0 ]; then
  echo -e ${red}"There are no PDF files in here. Abort operation."${nc}
  exit 99
fi

shopt -s nullglob

files=()
for pdf in *.pdf; do
  if [ $(echo "$pdf" | grep -c mergedpdf-) -eq 0 ]; then
    files+=( "$pdf" )
  fi
done

shopt -u nullglob

filename="mergedpdf-$(date +%s).pdf"
pdftk "${files[@]}" cat output "$filename"
if [[ "$?" -eq 0 ]]; then
  echo -e ${green}"PDF files has been merged into $filename"${nc}
else
  echo -e ${red}"Something went wrong. Merging FAILED."${nc}

exit 0
