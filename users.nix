{lib, ...}: let
  keys = import ./keys.nix;

  # TODO: Change to use `lib.strings.toSentenceCase` once available in our nixpkgs drv.
  toSentenceCase = with lib;
    str:
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
    }) {} keys.users;
}
