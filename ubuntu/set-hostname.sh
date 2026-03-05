#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 <hostname> [fqdn]" >&2
  echo "Example: $0 myhost myhost.example.local" >&2
}

if [[ ${1-} == "" ]]; then
  if [[ ! -t 0 ]]; then
    usage
    exit 1
  fi

  echo "Tento skript na Ubuntu nastaví hostname a runtime kernel.hostname." >&2
  echo "Co udělá:" >&2
  echo "- Nainstaluje balíček libnss-myhostname" >&2
  echo "- Nastaví trvalý hostname přes hostnamectl" >&2
  echo "- Nastaví runtime kernel.hostname přes sysctl" >&2
  echo "" >&2

  read -r -p "Zadej hostname (např. myhost): " hostname
  if [[ -z "$hostname" ]]; then
    echo "Hostname je povinný." >&2
    exit 1
  fi

  read -r -p "Zadej FQDN (volitelné, Enter = použít hostname): " fqdn
  if [[ -z "$fqdn" ]]; then
    fqdn="$hostname"
  fi
else
  hostname="$1"
  fqdn="${2-$hostname}"
fi

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
