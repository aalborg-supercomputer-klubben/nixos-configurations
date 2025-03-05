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
    mads = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCTefeRmo6GME/t0C72h1o5VWcqYHKbl4aiR60A6k+zbEnqObUxHg1yj5b3+AeJRQjcYG//nwZhfgnLqPBASGUTyjn63CmWURx1+8ZDZN6uIhif/s+PEwjU/uuXW+2inEr+zGpRJZ75YuxWuL4L8g/yXj5HB8PbIuYpWwDq+UQOuOS8K52mC035oKZakCzR1GiJQJe4kUokDbhrNeYwW6p/K6wbFqNMQSJs1gkZ+S4NBXWEEtVaPwCpZ4K5fBOkywCLkMU6UZFvYS/Fev/RayDFvdW9e5yulwlvJZyTavTM0YYqd7QUAfTRIzR46tDXuRm1bms1ZqGaDj2NolgPwCAvMjFZPt5CAfqU7eaRfmDKzgoqgq00vrC1gaEXnboMziTqMvugejpagPP0s/UAZD79fdXsHPdh6sKlsNPyrWqQdb8ksHgv4qT2Vg2hzXiENiLBbzIK6aLzu6BqwQXKP/7+wdvORR+1YtW+L/2E0ULEwcTqJWPsxBs3jCuBkXYu5RMmJZEUcVz1kZh2G/6/ZAzu/FxpVXkAYLfnSHa8oAIpny9D64/Qwfo2cTKmSc1D/crhtWsP3eBz8tACQO1AsQOqeq0iMqfY5buUSSGr4QxPpqPtDxNGrO2peCTnCHuUSX+Cge11+doln061JR236HOoxxNCbkc7QWGNQsqxSJxB3Q== mads@laptop-mads"];
    sofie = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJvgn0kSAboULv37yLS1fGwByGSudhbQGrP/RrO7+cH+"];
  };
}
