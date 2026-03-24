# Hercules CI agent configuration with sops-nix managed secrets.
# See: https://docs.hercules-ci.com/hercules-ci/getting-started/deploy/nixos/
{config, ...}: {
  services.hercules-ci-agent = {
    enable = true;
    settings = {
      clusterJoinTokenPath = config.sops.secrets."hercules-ci/cluster-join-token".path;
      binaryCachesPath = config.sops.secrets."hercules-ci/binary-caches".path;
      secretsJsonPath = config.sops.templates."hercules-ci-secrets.json".path;
    };
  };

  sops.secrets."hercules-ci/cluster-join-token" = {
    sopsFile = ../secrets/hercules-ci.sops.yaml;
    owner = "hercules-ci-agent";
  };

  sops.secrets."hercules-ci/binary-caches" = {
    sopsFile = ../secrets/hercules-ci.sops.yaml;
    owner = "hercules-ci-agent";
  };

  sops.secrets."hercules-ci/cachix-activate-token" = {
    sopsFile = ../secrets/hercules-ci.sops.yaml;
    owner = "hercules-ci-agent";
  };

  sops.templates."hercules-ci-secrets.json" = {
    owner = "hercules-ci-agent";
    content = builtins.toJSON {
      "default-cachix-activate" = {
        kind = "Secret";
        condition.and = [
          {is_owner = "aalborg-supercomputer-klubben";}
          {is_repo = "nixos-configurations";}
          "isDefaultBranch"
        ];
        data.cachixActivateToken = config.sops.placeholder."hercules-ci/cachix-activate-token";
      };
    };
  };
}
