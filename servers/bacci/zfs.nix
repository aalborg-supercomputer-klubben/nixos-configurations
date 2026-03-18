{...}: {
  boot.supportedFilesystems = ["zfs"];
  boot.zfs = {
    forceImportRoot = false; # Recommended, as the default bypasses ZFS safeguards
  };

  networking.hostId = "19dd82c0"; # Prevents importing the zpool on the wrong machine
}