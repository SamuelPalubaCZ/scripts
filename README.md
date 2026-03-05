# scripts

## Ubuntu: set-hostname

Bezpečné použití je skript nejdřív stáhnout, zkontrolovat a spustit ručně. Pokud přesto použiješ `curl | bash`, tak s parametry:

```bash
curl -fsSL https://raw.githubusercontent.com/SamuelPalubaCZ/scripts/main/ubuntu/set-hostname.sh | bash -s -- <hostname> <fqdn>
```

Příklad:

```bash
curl -fsSL https://raw.githubusercontent.com/SamuelPalubaCZ/scripts/main/ubuntu/set-hostname.sh | bash -s -- myhost myhost.example.local
```
