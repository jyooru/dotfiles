{ config, ... }:
{
  users.users.joel.openssh.authorizedKeys.keyFiles = [
    ./thinkpad-e580/id_rsa.joel.pub
    ./thinkpad-e580/id_rsa.root.pub
    ./portege-r700-a/id_rsa.root.pub
    ./portege-r700-b/id_rsa.root.pub
    ./portege-z930/id_rsa.root.pub
    ./ga-z77-d3h/id_rsa.root.pub
  ];
  users.users.root.openssh.authorizedKeys.keyFiles = [
    ./thinkpad-e580/id_rsa.root.pub
    ./portege-r700-a/id_rsa.root.pub
    ./portege-r700-b/id_rsa.root.pub
    ./portege-z930/id_rsa.root.pub
    ./ga-z77-d3h/id_rsa.root.pub
  ];

  modules = {
    config = {
      distributedBuild.enable = false; # TODO
    };
    hardware = {
      android = { enable = false; supportSamsung = false; };
      video = {
        amdgpu.enable = false;
      };
      iphone = { enable = false; user = "joel"; };
    };
    programs = {
      alacritty.enable = false;
      bash.enable = true;
      betterlockscreen.enable = false;
      git.enable = true;
      ranger.enable = true;
      rofi.enable = false;
      starship.enable = true;
      vscode.enable = false;
    };
    services = {
      polybar.enable = false;
      networking.nebula.enable = true;
      x11.window-manager.bspwm.enable = false;
    };
    # system.boot.loader.systemd-boot = {
    #   enable = false; # TODO: multiple devices. setup below
    #   # device = "/dev/disk/by-uuid/646fc0f1-2d8a-4901-ae89-559154bfe288";
    # };
    packages = {
      apps = false;
      code = false;
      desktopEnvironment = false;
      tools = true;
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 8000 443 44300 ];
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
            proxy_protocol on;
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
            proxy_protocol on;
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
    syncthing = {
      enable = true;
    };
  };
  home-manager.users.joel.home.file."nodeCaddyfile" = {
    target = "node/config/Caddyfile";
    text = ''
      import clusterCaddyfile

      ${config.networking.hostName}.dev.joel.tokyo {
        import joel.tokyo
        respond "Hello world"
      }

      nix.${config.networking.hostName}.dev.joel.tokyo {
        import joel.tokyo
        respond "Hello world"
      }

      syncthing.srv.${config.networking.hostName}.dev.joel.tokyo {
        reverse_proxy 172.17.0.1:8384
      }

      ipfs.srv.${config.networking.hostName}.dev.joel.tokyo {
        import joel.tokyo
        respond "Hello world"
      }
    '';
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
  };
}
