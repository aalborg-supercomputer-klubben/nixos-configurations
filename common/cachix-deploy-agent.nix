# Cachix Deploy agent: pulls and activates deployments triggered by Hercules CI.
# Agent name is inferred from the hostname.
# Each machine has its own token keyed by hostname in the sops file.
{config, ...}: {
  services.cachix-agent.enable = true;

  sops.secrets."cachix-agent/${config.networking.hostName}" = {
    sopsFile = ../secrets/cachix-agent.sops.yaml;
    path = "/etc/cachix-agent.token";
  };
}
