{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.alfis;

  toml = pkgs.formats.toml { };
  configFile = toml.generate "alfis.toml" cfg.settings;
in

{
  options.services.alfis = {
    enable = mkEnableOption "Alternative Free Identity System";

    package = mkPackageOption pkgs "alfis" {
      default = [ "alfis-nogui" ];
    };

    settings = {
      origin = mkOption {
        default = "0000001D2A77D63477172678502E51DE7F346061FF7EB188A2445ECA3FC0780E";
        type = types.str;
        description = ''
          The hash of first block in a chain to know with which nodes to work.
        '';
      };

      key_files = mkOption {
        default = [ ];
        type = types.listOf types.path;
        description = ''
          Paths to your key files to load automatically
        '';
      };

      check_blocks = mkOption {
        default = 8;
        type = types.ints.unsigned;
        description = ''
          How many last blocks to check on start
        '';
      };

      net = {
        peers = mkOption {
          default = [
            "peer-v4.alfis.name:4244"
            "peer-v6.alfis.name:4244"
            "peer-ygg.alfis.name:4244"
          ];
          type = types.listOf types.str;
          description = ''
            All bootstrap nodes
          '';
        };

        listen = mkOption {
          default = "[::]:4244";
          type = types.str;
          description = ''
            Your node will listen on that address for other nodes to connect
          '';
        };

        public = mkOption {
          default = true;
          type = types.bool;
          description = ''
            Set true if you want your IP to participate in peer-exchange, or false otherwise
          '';
        };

        yggdrasil_only = mkOption {
          default = false;
          type = types.bool;
          description = ''
            Allow connections to/from Yggdrasil only (https://yggdrasil-network.github.io)
          '';
        };
      };

      dns = {
        listen = mkOption {
          default = "127.0.0.1:53";
          type = types.str;
          description = ''
            Your DNS resolver will be listening on this address and port (Usual port is 53)
          '';
        };

        threads = mkOption {
          default = 50;
          type = types.ints.positive;
          description = ''
            How many threads to spawn by DNS server
          '';
        };

        forwarders = mkOption {
          default = [ "https://dns.adguard.com/dns-query" ];
          type = types.listOf types.str;
          description = ''
            Where to forward non-alfis requests to
          '';
        };

        bootstraps = mkOption {
          default = [ "9.9.9.9:53" "94.140.14.14:53" ];
          type = types.listOf types.str;
          description = ''
            Bootstrap DNS-servers to resolve domains of DoH providers
          '';
        };

        hosts = mkOption {
          default = [ ];
          type = types.listOf types.path;
          description = ''
            Hosts file support (resolve local names or block ads)
          '';
        };
      };

      mining = {
        threads = mkOption {
          default = 0;
          type = types.ints.unsigned;
          description = ''
            How many CPU threads to spawn for mining, zero = number of CPU cores
          '';
        };
        lower = mkOption {
          default = true;
          type = types.bool;
          description = ''
            Set lower priority for mining threads
          '';
        };
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.alfis = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      description = "Start the Alfis daemon.";
      serviceConfig = {
        DynamicUser = true;
        AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ];
        CapabilityBoundingSet = [ "CAP_NET_BIND_SERVICE" ];
        ExecStart = "${cfg.package}/bin/alfis -n -c ${configFile}";
        Restart = "always";
        StateDirectory = "alfis";
        WorkingDirectory = "/var/lib/alfis";
      };
    };
  };
}
