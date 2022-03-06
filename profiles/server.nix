{ config, lib, ... }:
{
  # TODO: refactor

  users.users.joel.openssh.authorizedKeys.keyFiles = [
    ../hosts/thinkpad-e580/keys/ssh-joel.pub
    ../hosts/thinkpad-e580/keys/ssh-root.pub
    ../hosts/portege-r700-a/keys/ssh-root.pub
    ../hosts/portege-r700-b/keys/ssh-root.pub
    ../hosts/portege-z930/keys/ssh-root.pub
    ../hosts/ga-z77-d3h/keys/ssh-root.pub
  ];
  users.users.root.openssh.authorizedKeys.keyFiles = [
    ../hosts/thinkpad-e580/keys/ssh-root.pub
    ../hosts/portege-r700-a/keys/ssh-root.pub
    ../hosts/portege-r700-b/keys/ssh-root.pub
    ../hosts/portege-z930/keys/ssh-root.pub
    ../hosts/ga-z77-d3h/keys/ssh-root.pub
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" "armv6l-linux" ];

  networking.firewall.allowedTCPPorts = [ 80 8000 443 44300 6881 ];
  networking.firewall.allowedUDPPorts = [ 6881 ];
  networking.firewall.interfaces."docker0".allowedTCPPorts = [ 5000 8384 ];
  services = {
    nginx = {
      # :80 -> localhost:8001 (http)
      # :8000 -> cluster:8001 (http)
      # :443 -> localhost:8001 (https)
      # :44300 -> cluster:44301 (https)
      enable = true;
      config = ''
        worker_processes 4;

        events {
        }

        http {
        }

        stream {
          server {
            listen 80;
            listen [::]:80;
            proxy_pass localhost:8001;
          }

          upstream http_servers {
            server 10.42.0.11:8001;
            server 10.42.0.12:8001;
            server 10.42.0.13:8001;
            server 10.42.0.14:8001;
          }

          server {
            listen 8000;
            listen [::]:8000;
            proxy_pass http_servers;
          }

          server {
            listen 443;
            listen [::]:443;
            proxy_protocol on;
            proxy_pass localhost:44301;
          }

          upstream https_servers {
            server 10.42.0.11:44301;
            server 10.42.0.12:44301;
            server 10.42.0.13:44301;
            server 10.42.0.14:44301;
          }

          server {
            listen 44300;
            listen [::]:44300;
            proxy_protocol on;
            proxy_pass https_servers;
          }
        }
      '';
    };
    nix-serve = {
      enable = true;
      secretKeyFile = "/var/binary-cache.pem";
    };
    syncthing = {
      enable = true;
      guiAddress = "0.0.0.0:8384";
    };
  };
  systemd.services.nix-serve.environment.HOME = "/dev/null";
  home-manager.users.joel.home.file."nodeCaddyfile" = {
    target = "node/config/Caddyfile";
    text = let inherit (config.networking) domain fqdn hostName; in
      ''
        import clusterCaddyfile

        tmp.${domain} {
          import joel.tokyo
          reverse_proxy 10.42.0.1:8080
        }

        ${fqdn} {
          import joel.tokyo
          respond "Hello world"
        }

        nix.${fqdn} {
          import joel.tokyo
          reverse_proxy 172.17.0.1:5000
        }

        syncthing.${fqdn} {
          import joel.tokyo
          reverse_proxy 172.17.0.1:8384
        }

        ipfs.${fqdn} {
          import joel.tokyo
          respond "Hello world"
        }
      '' + (if hostName == "portege-z930" then ''
        vaultwarden.${domain} {
          import joel.tokyo
          reverse_proxy 172.17.0.1:8002
        }
      '' else "");
  };
  virtualisation.oci-containers.containers = {
    "caddy" = {
      image = "jyooru/caddy";
      ports = [ "8001:80" "44301:443" ];
      volumes = [
        "/home/joel/node/config/Caddyfile:/etc/caddy/Caddyfile:ro" # ^
        "/home/joel/cluster/config/Caddyfile:/etc/caddy/clusterCaddyfile:ro" # not public
        "/home/joel/node/data/caddy:/data"
        "/home/joel/node/log/caddy:/var/log/caddy"
        "/home/joel/cluster/www:/srv:ro"
      ];
    };
    "streamr" = lib.mkIf (config.networking.hostName != "portege-z930") {
      image = "streamr/broker-node:testnet";
      # ports in host config
      extraOptions = [ "--tty" ];
      volumes = [ "/home/joel/node/config/streamr:/root/.streamr" ];
    };
  };
}


