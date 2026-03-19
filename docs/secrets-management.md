# Secrets management

Secrets are managed through [sops](https://github.com/getsops/sops) and
consumed by NixOS via [`sops-nix`](https://github.com/Mic92/sops-nix).
All ed25519 SSH keys in `keys.nix` automatically get age keys derived for them.

## First-time setup

Derive an age private key from your ed25519 SSH key:

```sh
nix run .#sops-first-run
```

This appends your age private key to `~/.config/sops/age/keys.txt`.
If your key is not at `~/.ssh/id_ed25519`, pass the path explicitly:

```sh
nix run .#sops-first-run -- ~/.ssh/my_ed25519_key
```

You can now encrypt and decrypt any `*.sops.yaml` file in the repo.

## Creating and editing secrets

Secret files must match `*.sops.yaml` (the pattern in `.sops.yaml`).
To create or edit a secret:

```sh
sops path/to/secret.sops.yaml
```

Sops will open your `$EDITOR` with the decrypted content and re-encrypt on save.

## Enrolling a new user

1. Add their ed25519 SSH public key to `keys.nix` under `users`.
2. Run `nix run .#sops-gen-config` to regenerate `.sops.yaml`.
3. Run `sops updatekeys <secret>.sops.yaml` for each secret they need access to.
4. Commit both `keys.nix` and `.sops.yaml`.

## Adding secrets access to a new host

1. Install NixOS on the host.
2. Get the host key:
   ```sh
   ssh-keyscan -t ed25519 <host> 2>/dev/null | awk '{print $2 " " $3}'
   ```
3. Add the key to `keys.nix` under `servers`.
4. Run `nix run .#sops-gen-config` to regenerate `.sops.yaml`.
5. Run `sops updatekeys <secret>.sops.yaml` for each relevant secret.
6. Deploy the configuration to the machine.

## Removing a user or server

1. Remove their key(s) from `keys.nix`.
2. Run `nix run .#sops-gen-config` to regenerate `.sops.yaml`.
3. Run `sops updatekeys <secret>.sops.yaml` to remove the key from each secret.
4. Rotate the data-key: `sops --rotate --in-place <secret>.sops.yaml`.
5. Rotate any API keys or credentials that the removed key had access to.

> **Warning**: Always run `--rotate --in-place` after removing a key.
> `sops updatekeys` alone only re-encrypts the data-key for the remaining keys,
> but the old data-key (which the removed user still has) remains valid.
> Rotating replaces the data-key entirely.
