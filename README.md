# scripts

Kolekce nasaditelných skriptů pro rychlé operace na serverech.

## Jak spouštět skripty

Bezpečný postup je skript nejdřív stáhnout, zkontrolovat a spustit ručně. Pokud přesto použiješ `curl | bash`, vždy přidej parametry a ověř URL.

## Seznam skriptů

| Skript | OS | Popis | Použití |
| --- | --- | --- | --- |
| `ubuntu/set-hostname.sh` | Ubuntu | Nastaví hostname a runtime `kernel.hostname`, doinstaluje `libnss-myhostname` | `curl -fsSL https://raw.githubusercontent.com/SamuelPalubaCZ/scripts/main/ubuntu/set-hostname.sh \
  | bash -s -- <hostname> <fqdn>` |

## Ubuntu: set-hostname

Skript nastaví hostname přes `hostnamectl`, runtime `kernel.hostname` přes `sysctl` a nainstaluje `libnss-myhostname`.

Použití přes `curl | bash`:

```bash
curl -fsSL https://raw.githubusercontent.com/SamuelPalubaCZ/scripts/main/ubuntu/set-hostname.sh \
  | bash -s -- <hostname> <fqdn>
```

Příklad:

```bash
curl -fsSL https://raw.githubusercontent.com/SamuelPalubaCZ/scripts/main/ubuntu/set-hostname.sh \
  | bash -s -- myhost myhost.example.local
```

Interaktivní režim:

- Bez parametrů se skript zeptá na hodnoty (jen při běhu v TTY, ne přes pipe).
