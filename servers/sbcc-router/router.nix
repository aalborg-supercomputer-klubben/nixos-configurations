{ ... }: {
  networking.firewall.extraCommands = ''
    # Set up symmetrical NAT  on packets from LAN to WAN
    iptables -t nat -A POSTROUTING -o enp1s0u1 -j MASQUERADE
  '';

  services.kea.dhcp4 = {
    enable = true;
    settings = {
      rebind-timer = 2000;
      renew-timer = 1000;
      valid-lifetime = 4000;

      interfaces-config.interfaces = [ "end0" ];

      lease-database = {
        name = "/var/lib/kea/dhcp4.leases";
        persist = true;
        type = "memfile";
      };

      subnet4 = [
        {
          id = 1;
          pools = [
            {
              pool = "10.0.0.2 - 10.0.0.255";
            }
          ];
          subnet = "10.0.0.1/8";
        }
      ];

      option-data = [
        {
          name = "routers";
          data = "10.0.0.1";
        }
      ];
    };
  };

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
  };
}