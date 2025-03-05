# nixos-configurations

Set up `.ssh/config`:
```sshconfig
Host montoya normark huttel bacci albano aaen
  CanonicalDomains aalborg.supercomputer.club
  User username
  IdentityFile ~/.ssh/id_ed25519
```

To deploy new configurations, use the interactive deploy script:
```bash
./bin/deploy ...
```
For more options, check `./bin/deploy --help`.

## Configured hostnames

A records configured under `aalborg.supercomputer.club`.

| IP Address    | A Record | Configured |
|---------------|----------|------------|
| 172.25.11.215 | montoya  | ✅         |
| 172.25.11.216 | normark  | ✅         |
| 172.25.11.217 | huttel   | ❌         |
| 172.25.11.218 | bacci    | ❌         |
| 172.25.11.219 | albano   | ❌         |
| 172.25.11.220 | aaen     | ❌         |
