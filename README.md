# rpi-youtube-socks-proxy

## Install
```bash
curl -fsSL https://raw.githubusercontent.com/CodingJediKnight/rpi-youtube-socks-proxy/main/install.sh | bash
sudo systemctl daemon-reload
sudo systemctl start byedpi.service
sudo systemctl status byedpi.service
sudo systemctl enable byedpi.service
```