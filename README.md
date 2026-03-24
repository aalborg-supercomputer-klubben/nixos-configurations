# nixos-configurations

[![Hercules CI](https://hercules-ci.com/api/v1/site/github/account/aalborg-supercomputer-klubben/project/nixos-configurations/badge)](https://hercules-ci.com/github/aalborg-supercomputer-klubben/nixos-configurations/status)
[![Cachix Deploy](https://img.shields.io/badge/cachix--deploy-aalborg--supercomputer--klubben-blue.svg)](https://app.cachix.org/organization/aalborg-supercomputer-klubben/deploy/workspace/aalborg-supercomputer-klubben)

Set up `.ssh/config`:

```sshconfig
Host montoya normark huttel bacci albano aaen
  User username
  IdentityFile ~/.ssh/id_ed25519
  IdentitiesOnly yes
  CanonicalDomains aalborg.supercomputer.club
  CanonicalizeHostname yes
  CanonicalizeMaxDots 0
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
| 172.25.11.217 | huttel   | ✅         |
| 172.25.11.218 | bacci    | ✅         |
| 172.25.11.219 | albano   | ❌         |
| 172.25.11.220 | aaen     | ❌         |

## AAU VPN

To access the servers outside of the campus network.

*Requires MFA to be enabled and updated on your AAU account.*

| Setting      | Value                           |
|--------------|---------------------------------|
| VPN Protocol | Cisco AnyConnect or OpenConnect |
| Gateway      | `ssl-vpn1.aau.dk`               |
| User Agent   | `AnyConnect`                    |
| Token Mode   | `Disabled`                      |
