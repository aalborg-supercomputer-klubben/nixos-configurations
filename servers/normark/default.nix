{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  # TODO: Figure out if this is using defaults EFI support or if 
  # this is a BIOS install.
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.

  # disable mitigations (performance increase)
  boot.kernelParams = ["mitigations=off"];

  networking.hostName = "normark"; # Define your hostname.

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

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
