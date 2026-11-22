#!/usr/bin/env bash
set -e

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or with sudo:"
  echo "sudo ./uninstall.sh"
  exit 1
fi

echo "==> Stopping and disabling fdm-balancer service..."
systemctl stop fdm-balancer.service 2>/dev/null || true
systemctl disable fdm-balancer.service 2>/dev/null || true

echo "==> Removing installed files..."
rm -f /usr/local/bin/fdm-balancer
rm -f /etc/systemd/system/fdm-balancer.service

systemctl daemon-reload
echo "Uninstallation complete."
