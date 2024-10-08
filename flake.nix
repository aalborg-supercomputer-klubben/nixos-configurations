{
  description = "Aalborg supercomputer klub nix flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in rec {
    nixosConfigurations = {
      grundfos-fastboy = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./servers/fastboy
          ./common.nix
        ];
      };
      grundfos-oldboy = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./servers/oldboy
          ./common.nix
        ];
      };
    };
    packages.${system} = {
      fastboy-vm = nixosConfigurations.grundfos-fastboy.config.system.build.vm;
      oldboy-vm = nixosConfigurations.grundfos-oldboy.config.system.build.vm;
    };
  };
}
