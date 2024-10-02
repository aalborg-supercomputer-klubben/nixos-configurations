{
  users.users = {
    mast3r = {
      isNormalUser = true;
      description = "https://github.com/Mast3rwaf1z";
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG5Lc6TJ+9DmxiSmUBb08glscp3aL4Xm0v0j2jVlZTUX mast3r@laptop"];
    };
    tobias = {
      isNormalUser = true;
      description = "";
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILHWivy/fWfI1RnUAKLC4azHaydg2EC4JCvvDJs2/d90 tobias@nixos"];
    };
    casper = {
      isNormalUser = true;
      description = "";
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOyNgY9a3t7ZWT9MnM3ePe5m+MNIvsoZWo7OqU7JsPqn caspernyvang@gmail.com"];
    };
  };
}
