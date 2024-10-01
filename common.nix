# Common configuration for all nixos machines

{ config, lib, pkgs, ... }:

{

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "dk";

  users.users.builder = {
    isNormalUser = true;
    description = "Remote builder";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILHWivy/fWfI1RnUAKLC4azHaydg2EC4JCvvDJs2/d90 tobias@nixos"
    ];
  };

  # Programs and packages

  programs.neovim.enable = true;

  programs.htop = {
    enable = true;
    settings = {
      show_cpu_frequency = true;
      show_cpu_temperature = true;
      hide_userland_threads = true;
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
    vim
    wget
    git
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  # Trim ssds weekly
  services.fstrim.enable = true;

  # Upgrade the system automatically
  # system.autoUpgrade = {
  #   enable = true;
  #   autoReboot = false;
  #
  #   # Prevent silencing of build output
  #   flags = lib.mkForce [];
  # };

  # Automatically garbage collect old versions
  nix.gc = {
    automatic = true;
    options = "-d";
  };

  virtualisation.vmVariant = {
    users.users.root.password = "1234";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
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
