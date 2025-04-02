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
      huttel = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./servers/huttel
          ./common.nix
        ];
      };
      sbcc-router = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./servers/sbcc-router
          ./common.nix
        ];
      };
    };
    packages.${system} = {
      montoya-vm = nixosConfigurations.montoya.config.system.build.vm;
      normark-vm = nixosConfigurations.normark.config.system.build.vm;
      huttel-vm = nixosConfigurations.normark.config.system.build.vm;
    };
  };
}
