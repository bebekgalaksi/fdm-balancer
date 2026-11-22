# FDM Load Balancer

A lightweight daemon that bonds multiple active WAN network interfaces (such as Wi-Fi and USB Tethering / Mobile Data) for **Free Download Manager (FDM)** using `dispatch-proxy` and Linux policy routing.

All other system applications (browsers, terminal, gaming, etc.) remain untouched and route normally through the default gateway.

## Features

- **Isolated to FDM:** Uses a local SOCKS5 proxy (`127.0.0.1:1080`), leaving system traffic undisturbed.
- **Dynamic Interface Detection:** Automatically detects when a secondary network (e.g., USB tethering) is connected or disconnected.
- **Auto-Healing Routing:** Continuously monitors custom policy routing tables (`table 101`, `table 102`, etc.) and automatically restores routes if flushed by NetworkManager or DHCP lease renewal.
- **Auto-Restarting Proxy:** Supervises `dispatch-proxy` and recovers automatically from interface disconnects.

## Requirements

- Linux with `systemd` and `iproute2`
- Python 3.8+
- Node.js & `npm`
- `dispatch-proxy` (`npm install -g dispatch-proxy`)
- Free Download Manager (FDM)

## Installation

```bash
git clone https://github.com/bebekgalaksi/fdm-balancer.git
cd fdm-balancer
sudo chmod +x install.sh uninstall.sh fdm-balancer
sudo ./install.sh
```

## FDM Configuration

Open Free Download Manager:
1. Go to **Settings > Network > Proxy settings**.
2. Select **SOCKS5**.
3. Set **Host** to `127.0.0.1` and **Port** to `1080`.
4. (Recommended) Set **Maximum connections per server** to at least **8 to 16** for optimal multi-connection bandwidth aggregation.

## Managing the Service

- **Check status:** `systemctl status fdm-balancer.service`
- **View live logs:** `journalctl -u fdm-balancer.service -f`
- **Restart service:** `sudo systemctl restart fdm-balancer.service`
- **Uninstall:** `sudo ./uninstall.sh`
