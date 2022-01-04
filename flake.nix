{
  description = "NixOS configuration";

  inputs = {
    deploy-rs.url = "github:serokell/deploy-rs";
    digga = { url = "github:divnix/digga"; inputs = { deploy.follows = "deploy-rs"; nixpkgs.follows = "nixpkgs"; nixlib.follows = "nixpkgs"; home-manager.follows = "home-manager"; }; };
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small"; # change back to nixos-unstable on next update
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, digga, nixpkgs, home-manager, deploy-rs, flake-utils, nur, ... } @ inputs:
    let
      overlays = import ./overlays;
      overlay = overlays.pkgs;
    in
    digga.lib.mkFlake
      {
        inherit self inputs;

        channelsConfig = { allowUnfree = true; };
        channels = { nixpkgs = { overlays = [ nur.overlay ]; }; };


        nixos = {
          hostDefaults = { system = "x86_64-linux"; channelName = "nixpkgs"; modules = [ ./default.nix home-manager.nixosModules.home-manager ]; };
          imports = [ (digga.lib.importHosts ./hosts) ];
          importables = rec {
            profiles = digga.lib.rakeLeaves ./profiles // {
              users = digga.lib.rakeLeaves ./users;
            };
            suites = with profiles; rec {
              base = [ users.joel users.root ];
            };
          };
        };

        home = {
          importables = rec {
            profiles = digga.lib.rakeLeaves ./users/profiles;
            suites = with profiles; rec {
              base = [ git shell ];
              gui = base ++ [ bar browser compositor editor file-manager window-manager ];
            };
          };
          users = {
            joel = { suites, ... }: { imports = suites.gui; };
            root = { suites, ... }: { imports = suites.base; };
          };
        };

        homeConfigurations = digga.lib.mkHomeConfigurations self.nixosConfigurations;

        deploy.nodes = digga.lib.mkDeployNodes self.nixosConfigurations { };

        inherit overlay overlays;

      } // (flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; }; in
      with pkgs;
      rec {
        devShell = mkShell {
          packages = [ nixpkgs-fmt deploy-rs.outputs.packages.${system}.deploy-rs ];
        };

        legacyPackages = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
        packages = import ./pkgs { inherit pkgs; };
      }
    ));
}
