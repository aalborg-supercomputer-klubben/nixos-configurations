# Configuration file for the grundfos-oldboy server
# Specs:
# 24 cores
# 32 GB ram

{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ../../common.nix
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  # disable mitigations (performance increase)
  boot.kernelParams = [ "mitigations=off" ];

  networking.hostName = "grundfos-oldboy"; # Define your hostname.

  networking.useDHCP = false;
  networking.interfaces.eno1.ipv4.addresses = [
    {
      address = "172.25.11.216";
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
