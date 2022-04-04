{ config, pkgs, profiles, secrets, ... }:
{
  imports = with profiles; [ yggdrasil ];

  # TODO: refactor

  users.users.joel.openssh.authorizedKeys.keyFiles = [
    ../../hosts/thinkpad-e580/keys/ssh-joel.pub
    ../../hosts/thinkpad-e580/keys/ssh-root.pub
    ../../hosts/portege-r700-a/keys/ssh-root.pub
    ../../hosts/portege-r700-b/keys/ssh-root.pub
    ../../hosts/portege-z930/keys/ssh-root.pub
    ../../hosts/ga-z77-d3h/keys/ssh-root.pub
  ];
  users.users.root.openssh.authorizedKeys.keyFiles = [
    ../../hosts/thinkpad-e580/keys/ssh-root.pub
    ../../hosts/portege-r700-a/keys/ssh-root.pub
    ../../hosts/portege-r700-b/keys/ssh-root.pub
    ../../hosts/portege-z930/keys/ssh-root.pub
    ../../hosts/ga-z77-d3h/keys/ssh-root.pub
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" "armv6l-linux" ];

  age.secrets."tls-joel.tokyo" = {
    file = secrets."tls-joel.tokyo";
    owner = "caddy";
    group = "caddy";
  };
  networking.firewall.interfaces."nebula0" = {
    allowedTCPPorts = [ 53 80 8000 8001 443 44300 44301 ];
    allowedUDPPorts = [ 53 ];
  };
  services = {
    nginx = {
      # :80 -> localhost:8001
      # :8000 -> cluster:8001
      # :443 -> localhost:44301
      # :44300 -> cluster:44301
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
            # server 10.42.0.12:8001;
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
            # server 10.42.0.12:44301;
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
    caddy = {
      enable = true;
      package = pkgs.caddy-modded;
      globalConfig = ''
        http_port 8001
        https_port 44301

        servers {
          listener_wrappers {
            proxy_protocol
            tls
          }
        }
      '';
      extraConfig =
        let
          inherit (config.networking) domain fqdn hostName;
        in
        ''
          (joel.tokyo) {
            import /run/agenix/tls-joel.tokyo
          }

          joel.tokyo www.joel.tokyo {
            import joel.tokyo
            root * /srv/www/tokyo/joel/www
            file_server
            try_files {path} {path}.html {path}/
          }

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
            reverse_proxy 127.0.0.1:5000
          }

          syncthing.${fqdn} {
            import joel.tokyo
            reverse_proxy ${config.services.syncthing.guiAddress} {
              header_up ${config.services.syncthing.guiAddress}
            }
          }

          ipfs.${fqdn} {
            import joel.tokyo
            respond "Hello world"
          }
        '' + (if hostName == "portege-z930" then ''
          vaultwarden.${domain} {
            import joel.tokyo
            reverse_proxy 127.0.0.1:8002
          }
        '' else "");
    };
  };
}
