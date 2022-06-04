{
  services.alfis = {
    enable = true;

    settings = {
      net.yggdrasil_only = true;

      dns = {
        listen = "127.0.0.1:5354";

        # dnscrypt-proxy2 forwards to alfis
        forwarders = [ ];
        bootstraps = [ ];
      };
    };
  };
}
