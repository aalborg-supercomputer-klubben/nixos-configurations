{lib, ...}: let
  # TODO: Change to use `lib.strings.toSentenceCase` once available in our nixpkgs drv.
  toSentenceCase = with lib; str:
    lib.throwIfNot (isString str)
      "toSentenceCase does only accepts string values, but got ${typeOf str}"
      (
        let
          firstChar = substring 0 1 str;
          rest = substring 1 (stringLength str) str;
        in
        addContextFrom str (toUpper firstChar + toLower rest)
      );

in {
  # Enable sudo for @wheel group.
  security.sudo.enable = true;
  # Only users in the wheel group should have access to the sudo binary.
  security.sudo.execWheelOnly = true;
  # Do not require a password for sudo for users in the wheel group.
  security.sudo.wheelNeedsPassword = false;

  # Set up users with the same groups and username pattern.
  users.users = lib.attrsets.foldlAttrs (acc: userName: sshKeys:
    acc
    // {
      "${userName}" = {
        description = toSentenceCase userName;
        openssh.authorizedKeys.keys = sshKeys;
        isNormalUser = true;
        extraGroups = ["wheel"];
      };
    }) {} {
    mast3r = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG5Lc6TJ+9DmxiSmUBb08glscp3aL4Xm0v0j2jVlZTUX mast3r@laptop"];
    tobias = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILHWivy/fWfI1RnUAKLC4azHaydg2EC4JCvvDJs2/d90 tobias@nixos"];
    casper = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOyNgY9a3t7ZWT9MnM3ePe5m+MNIvsoZWo7OqU7JsPqn caspernyvang@gmail.com"];
    mads = [];
    sofie = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJvgn0kSAboULv37yLS1fGwByGSudhbQGrP/RrO7+cH+"];
  };
}
