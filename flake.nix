{
  description = "NixOS configuration";

  inputs = {
    comma.url = "github:nix-community/comma";
    deploy-rs.url = "github:serokell/deploy-rs";
    digga = {
      url = "github:divnix/digga";
      inputs = {
        deploy.follows = "deploy-rs";
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
    fenix.url = "github:nix-community/fenix";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, comma, digga, nixpkgs, home-manager, deploy-rs, flake-utils, nur, fenix, ... } @ inputs:

    let
      inherit (digga.lib) importHosts rakeLeaves mkDeployNodes mkHomeConfigurations mkFlake;

      supportedSystems = [ "x86_64-linux" ];

      overlays = import ./overlays;
      overlay = overlays.packages;
    in

    mkFlake
      {
        inherit self inputs overlay overlays supportedSystems;

        channelsConfig = { allowUnfree = true; };
        channels = {
          nixpkgs = {
            overlays = [
              (builtins.attrValues overlays)
              (final: _: { comma = import comma { pkgs = final; }; })
              fenix.overlay
              nur.overlay
            ];
          };
        };

        deploy.nodes = mkDeployNodes self.nixosConfigurations { };

        home = {
          importables = rec {
            profiles = rakeLeaves ./users/profiles;

            suites = with profiles; rec {
              base = [
                common
                git
                shell
                packages.tools
                ssh
              ];
              gui = base ++ [
                browser
                compositor
                editor
                file-manager
                launcher
                notification-daemon
                terminal-emulator
                packages.apps
                packages.code
                window-manager
              ];
            };
          };

          users = {
            joel = { suites, ... }: { imports = suites.gui; };
            root = { suites, ... }: { imports = suites.base; };
          };
        };

        homeConfigurations = mkHomeConfigurations self.nixosConfigurations;

        nixos = {
          hostDefaults = {
            system = "x86_64-linux";
            channelName = "nixpkgs";
            modules = [ home-manager.nixosModules.home-manager ];
          };

          imports = [ (importHosts ./hosts) ];
          importables = rec {
            profiles = rakeLeaves ./profiles // {
              users = rakeLeaves ./users;
            };
            suites = with profiles; rec {
              base = [ common file-sync locale networking ssh vpn ] ++ users;
              users = with profiles.users; [ joel root ];
              server = base ++ [ profiles.server ];
            };
          };
        };

        templates = import ./templates;
      }

    //

    (flake-utils.lib.eachSystem supportedSystems
      (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in

        with pkgs;

        rec {
          devShell = mkShell {
            packages = [
              deploy-rs.defaultPackage.${system}
              fish
              git
              nixpkgs-fmt
              nodePackages.node2nix
              nodePackages.prettier
              qtile
            ]
            ++ (import ./users/profiles/packages/code.nix { inherit pkgs; }).home.packages;
          };

          packages = import ./packages { inherit pkgs system; };
        }
      )
    );
}
