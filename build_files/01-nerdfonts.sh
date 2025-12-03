#!/bin/bash

fonts=(
  "CascadiaCode"
  "FiraCode"
  "Hack"
  "JetBrainsMono"
)

for font in "${fonts[@]}"; do
  echo "Installing font: $font"
  curl -L -o /tmp/$font.zip "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font.zip"
  if [ $? -ne 0 ]; then
    echo "Failed to download font: $font"
    continue
  fi

  unzip -q /tmp/$font.zip -d /usr/share/fonts/$font
  if [ $? -ne 0 ]; then
    echo "Failed to extract font: $font"
    continue
  fi

  rm /tmp/$font.zip
done

# Update font cache
fc-cache -f

echo "Fonts installation completed."
