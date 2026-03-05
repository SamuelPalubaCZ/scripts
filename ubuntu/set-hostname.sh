#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 <hostname> [fqdn]" >&2
  echo "Example: $0 myhost myhost.example.local" >&2
}

if [[ ${1-} == "" ]]; then
  usage
  exit 1
fi

hostname="$1"
fqdn="${2-$hostname}"

if [[ -f /etc/os-release ]]; then
  . /etc/os-release
  if [[ "${ID-}" != "ubuntu" && "${ID_LIKE-}" != *"ubuntu"* ]]; then
    echo "Tento skript je určen pro Ubuntu. Detekováno: ${ID-unknown}." >&2
    exit 1
  fi
fi

SUDO=""
if [[ "$(id -u)" != "0" ]]; then
  if command -v sudo >/dev/null 2>&1; then
    SUDO="sudo"
  else
    echo "Pro běh bez root je vyžadován sudo." >&2
    exit 1
  fi
fi

echo "Instaluji libnss-myhostname..."
$SUDO apt-get update
$SUDO apt-get install -y libnss-myhostname

echo "Nastavuji hostnamectl na '$hostname'..."
$SUDO hostnamectl set-hostname "$hostname"

echo "Nastavuji runtime kernel.hostname na '$fqdn'..."
$SUDO sysctl -w kernel.hostname="$fqdn"

echo "Hotovo."
