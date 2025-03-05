{
  description = "Aalborg supercomputer klub nix flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in rec {
    nixosConfigurations = {
      montoya = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./servers/montoya
          ./common.nix
        ];
      };
      normark = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./servers/normark
          ./common.nix
        ];
      };
    };
    packages.${system} = {
      montoya-vm = nixosConfigurations.montoya.config.system.build.vm;
      normark-vm = nixosConfigurations.normark.config.system.build.vm;
    };
  };
}
