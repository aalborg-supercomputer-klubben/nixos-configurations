{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../common.nix
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "montoya";

  networking.useDHCP = false;
  networking.interfaces.eno1.ipv4.addresses = [
    {
      address = "172.25.11.215";
      prefixLength = 24;
    }
  ];
  networking.defaultGateway = {
    address = "172.25.11.1";
    interface = "eno1";
  };
  networking.nameservers = [
    "172.18.21.2"
    "172.18.21.34"
  ];
}
