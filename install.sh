#!/usr/bin/env bash
set -e

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or with sudo:"
  echo "sudo ./install.sh"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Checking dependencies..."
if ! command -v dispatch >/dev/null 2>&1; then
  echo "dispatch-proxy not found. Installing via npm..."
  if ! command -v npm >/dev/null 2>&1; then
    echo "Error: npm is required to install dispatch-proxy."
    exit 1
  fi
  npm install -g dispatch-proxy
fi

echo "==> Installing fdm-balancer daemon..."
install -m 755 "$SCRIPT_DIR/fdm-balancer" /usr/local/bin/fdm-balancer
install -m 644 "$SCRIPT_DIR/fdm-balancer.service" /etc/systemd/system/fdm-balancer.service

echo "==> Enabling and starting service..."
systemctl daemon-reload
systemctl enable --now fdm-balancer.service

echo ""
echo "Installation complete!"
echo "Status: systemctl status fdm-balancer.service"
echo "Configure FDM Proxy Settings:"
echo "  Type: SOCKS5"
echo "  Host: 127.0.0.1"
echo "  Port: 1080"
