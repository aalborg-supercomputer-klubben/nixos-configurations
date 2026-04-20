{lib, ...}: let
  keys = import ../../keys.nix;
in {
  imports = [
    ./hardware-configuration.nix
    ./zfs.nix
  ];

  # Grant every configured user access to libvirt on this host only.
  users.users = lib.mapAttrs (_: _: {extraGroups = ["libvirtd"];}) keys.users;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "bacci";

  networking.useDHCP = false;
  networking.useNetworkd = true;
  systemd.network = {
    enable = true;

    # br0 is the LAN bridge. libvirt VMs attach to it directly so they
    # appear on the same L2 as the host.
    netdevs."10-br0" = {
      netdevConfig = {
        Kind = "bridge";
        Name = "br0";
      };
    };

    # Enslave the physical uplink to br0. It carries no L3 addresses.
    networks."20-eno1" = {
      matchConfig.Name = "eno1";
      networkConfig.Bridge = "br0";
      linkConfig.RequiredForOnline = "enslaved";
    };

    # Host addressing lives on br0.
    networks."30-br0" = {
      matchConfig.Name = "br0";
      address = ["172.25.11.218/24"];
      routes = [{Gateway = "172.25.11.1";}];
      networkConfig = {
        DNS = ["172.18.21.2" "172.18.21.34"];
        IPv6AcceptRA = false;
      };
      linkConfig.RequiredForOnline = "routable";
    };
  };
  services.resolved.enable = true;

  # Announce the host's MAC for its IPs out the physical uplink so the
  # upstream switch learns the bridge's addresses reliably.
  boot.kernel.sysctl = {
    "net.ipv4.conf.all.arp_announce" = 2;
    "net.ipv4.conf.br0.arp_announce" = 2;
    "net.ipv4.conf.br0.arp_notify" = 1;
    "net.ipv4.ip_forward" = 1;
  };

  # Virtualisation: libvirt/KVM. VM definitions are managed manually
  # (virsh define ...); this only provides the host-side services.
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      runAsRoot = false;
      swtpm.enable = true;
    };
  };
  programs.virt-manager.enable = true;
  boot.kernelModules = ["vhost_net"];

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

