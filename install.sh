#!/bin/bash

_have() { type "$1" &>/dev/null; }
! _have jq && echo "requires jq (apt install jq)" && exit 1

# byedpi install

user="hufrea"
repo="byedpi"
arch=$(uname -m)
latest=$(curl -sSL "https://api.github.com/repos/$user/$repo/releases/latest" | jq -r .tag_name)
version=$(echo $latest | cut -d. -f2)
version+=$(echo $latest | cut -d. -f3)
rel="https://github.com/$user/$repo/releases/download/$latest/byedpi-$version-$arch.tar.gz"
folder="$HOME/.local/bin"
mkdir -p "$folder"

echo "Downloading $rel to $folder" && \
curl -SL "$rel" -o "$folder/byedpi.tar.gz" && \
tar -xzvf "$folder/byedpi.tar.gz" -C "$folder" && \
rm -f "$folder/byedpi.tar.gz" && \
mv "$folder/ciadpi-$arch" "$folder/byedpi"

# service install

sudo touch /etc/systemd/system/byedpi.service
sudo bash -c "cat << EOF > /etc/systemd/system/byedpi.service
[Unit]
Description=ByeDPI Youtube fix
ConditionFileIsExecutable=$folder/byedpi

After=syslog.target network.target

[Service]
StartLimitInterval=5
StartLimitBurst=10
ExecStart=$folder/byedpi --hosts :\"youtube.com youtu.be googlevideo.com ytimg.com\" -p 7755 --tlsrec 3 --disorder 3

Restart=always
RestartSec=120

[Install]
WantedBy=multi-user.target
EOF"