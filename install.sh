#!/bin/bash

user="hufrea"
repo="byedpi"
arch=$(uname -m)
latest=$(curl -sSL "https://api.github.com/repos/$user/$repo/releases/latest" | jq -r .tag_name)
version=$(echo $latest | cut -d. -f2)
version+=$(echo $latest | cut -d. -f3)
rel="https://github.com/hufrea/byedpi/releases/download/$latest/byedpi-$version-$arch.tar.gz"
folder="$HOME/.local/bin"
mkdir -p "$folder"
echo "Downloading $rel to $folder"
curl -L "$rel" -o "$folder/byedpi.tar.gz"
tar -xzvf "$folder/byedpi.tar.gz" && rm -rf "$folder/byedpi.tar.gz"
mv "$folder/ciadpi-$arch" "$folder/ciadpi"