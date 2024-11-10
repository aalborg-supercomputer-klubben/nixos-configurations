{ config, lib, ... }: 

{
  options.asck = {
    interface = lib.mkOption {
      type = lib.types.str;
      default = "eno1";
    };
  };
}
