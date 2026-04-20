# Central key registry for SSH keys.
# Used by users.nix for SSH authorization and by sops for secrets encryption.
# All ed25519 keys here will automatically get age keys derived for sops.
{
  users = {
    tobias = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILHWivy/fWfI1RnUAKLC4azHaydg2EC4JCvvDJs2/d90 tobias@nixos"];
    sofie = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJvgn0kSAboULv37yLS1fGwByGSudhbQGrP/RrO7+cH+" "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDrXVmTxO4vDLti4qHNW1XZI9b5SHw0DhARg62RZ9Gym openpgp:0x1A71A10C"];
    alex = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILlUu5YydtsInNxcObVyM+8i2He160llmvJ/QE+z4sV7 alex@cachyos-x8664"];
    brian = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBS9jxNPsm1BDkUEiVgfzaziFAMLGNcUeesDuqwhMppf brianellingsgaard9@gmail.com"];
    tea = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKsCG/PjvMDMqlsb6o48u9/2qUhlbqiJ81ytuMtsJ1fL tea@h011089.wifi.general.client.rdns.aau.dk"];
    deekahy = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCz9NR4FapCSiXxTqLiGKXfHlcy189XAiIOnGYbSG/B8TBSxyV5FzHWjKCxZLDXcoBnXljsxtu1EmGtvQP3/AwOMbt95UCTLLt1gP8Uwgzilt8Bv3P2LxAZXGQRppU3GhmScaea1CXX0kwnIvtk8QzUzVPDW7eze/R+/Alkw1rXOV7ywV1cOcOEBsDFCJy2IlDA2siKQkO5+24XoCYOGwQhMzQAiqd87xPJAsGRVP6id9O1BBf4iojdtQcRj9fqnJUera825fufAfEZTHjg3q4f8QSd564JzG6LWHRyDSAtycioWaDBlvF9omaWSSrmRqABrZENPB3zhn/GykeCEA8b"];
  };

  # Server host ed25519 public keys.
  # Populate after initial NixOS install via:
  #   ssh-keyscan -t ed25519 <host>.aalborg.supercomputer.club 2>/dev/null | awk '{print $2 " " $3}'
  servers = {
    bacci = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGjoi4t81EHAqVUHI2fob/Q7WDNpeyEvXR5Au1GftWYH";
    montoya = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBFaeulWD0+hRNyZ1f5PnRYnVZOElZ87HfU67vW6MvX2";
    normark = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDTalGRnkfV5gdP4Z2MoEezPsrI1Ij0qfjw3Y3EfwUXS";
    huttel = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOXnQxtzP+7SwCgs1PoGlKR515qYDkfuQoR4ACkh738T";
  };
}
