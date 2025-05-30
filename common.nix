# Common configuration for all nixos machines

{ config, lib, pkgs, ... }:

{
  imports = [
    ./users.nix
  ];

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "dk";

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
    cacert # Contains certificates of SSL CAs
    hdparm
    tmux
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      X11Forwarding = true;
    };
  };

  # Trim ssds weekly
  services.fstrim.enable = true;

  # Enable BOINC lets use some power :)
  services.boinc.enable = true;

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
}
