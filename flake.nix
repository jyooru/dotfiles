{
  description = "NixOS configuration";

  inputs = {
    comma = { url = "github:nix-community/comma"; flake = false; };
    deploy-rs.url = "github:serokell/deploy-rs";
    digga = { url = "github:divnix/digga"; inputs = { deploy.follows = "deploy-rs"; nixpkgs.follows = "nixpkgs"; home-manager.follows = "home-manager"; }; };
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, comma, digga, nixpkgs, home-manager, deploy-rs, flake-utils, nur, nixos-hardware, ... } @ inputs:
    let
      inherit (digga.lib) importHosts rakeLeaves mkDeployNodes mkHomeConfigurations mkFlake;

      supportedSystems = [ "x86_64-linux" ];

      overlays = import ./overlays;
      overlay = overlays.packages;
    in
    mkFlake
      {
        inherit self inputs supportedSystems;

        channelsConfig = { allowUnfree = true; };
        channels = {
          nixpkgs = {
            overlays = [
              (builtins.attrValues overlays)
              nur.overlay
              (final: prev: { comma = import comma { pkgs = final; }; })
            ];
          };
        };

        nixos = {
          hostDefaults = { system = "x86_64-linux"; channelName = "nixpkgs"; modules = [ home-manager.nixosModules.home-manager ]; };
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

        home = {
          importables = rec {
            profiles = rakeLeaves ./users/profiles;
            suites = with profiles; rec {
              base = [ common git shell packages.tools ssh ];
              gui = base ++ [ browser compositor editor file-manager launcher notification-daemon terminal-emulator packages.apps packages.code window-manager ];
            };
          };
          users = {
            joel = { suites, ... }: { imports = suites.gui; };
            root = { suites, ... }: { imports = suites.base; };
          };
        };

        homeConfigurations = mkHomeConfigurations self.nixosConfigurations;

        deploy.nodes = mkDeployNodes self.nixosConfigurations { };

        templates = import ./templates;

        inherit overlay overlays;

      } // (flake-utils.lib.eachSystem supportedSystems (system:
      let pkgs = import nixpkgs { inherit system; }; in
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

        legacyPackages = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
        packages = import ./packages { inherit pkgs system; };
      }
    ));
}
