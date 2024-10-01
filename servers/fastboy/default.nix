# Configuration file for the grundfos-fastboy server
# Specs:
# 32 cores
# 128 GB ram

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

  networking.hostName = "grundfos-fastboy";

  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
}

