{
  networking = rec {
    domain = "joel.tokyo";
    firewall.enable = true;
    networkmanager = {
      enable = true;
      insertNameservers = [ "127.0.0.1" "::1" ];
    };
    search = [ domain ];
  };

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      bootstrap_resolvers = [ "1.1.1.1:53" "1.0.0.1:53" ];
      listen_addresses = [ "[::]:53" ];
      netprobe_timeout = 0;
      server_names = [ "cloudflare" "cloudflare-ipv6" ];
    };
    upstreamDefaults = true;
  };
}
