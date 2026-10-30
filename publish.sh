#!/bin/zsh
# Copies the latest install doc from the Obsidian lab folder and pushes it to GitHub Pages.
set -e
SRC="/Users/christainjackson/Documents/School/Sys Admin/arch-linux-install-lab"
DOC="$SRC/Arch Linux VM Installation - Christian Jackson.md"
cd "$(dirname "$0")"

cp "$DOC" index.md
rm -rf Attachments && mkdir Attachments
# copy only the images the doc references
grep -oE '\]\(Attachments/[^)]+\)' index.md | sed -E 's/^\]\(Attachments\/(.*)\)$/\1/' | sed 's/%20/ /g' | sort -u | while read -r img; do
  cp "$SRC/Attachments/$img" Attachments/
done

git add -A
git commit -m "Update install documentation" || echo "Nothing changed."
git push
