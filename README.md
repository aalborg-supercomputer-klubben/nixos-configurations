# nixos-configurations

Set up `.ssh/config`:
```sshconfig
Host grundfos-fastboy
  User username
  HostName 172.25.11.215
  IdentityFile ~/.ssh/id_ed25519

Host grundfos-oldboy
  User username
  HostName 172.25.11.216
  IdentityFile ~/.ssh/id_ed25519
```

To deploy new configurations, use the interactive deploy script:
```bash
./bin/deploy
```
For more options, check `./bin/deploy --help`.
