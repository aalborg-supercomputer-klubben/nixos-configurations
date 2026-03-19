# Sops-nix secrets management module.
# Each server decrypts secrets using its host ed25519 SSH key (converted to age).
{...}: {
  sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
}
