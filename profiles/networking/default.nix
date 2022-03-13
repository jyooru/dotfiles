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
      listen_addresses = [ "127.0.0.1:53" "[::1]:53" ];
      server_names = [ "cloudflare" "cloudflare-ipv6" ];
    };
    upstreamDefaults = true;
  };
}
