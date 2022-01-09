{
  description = "NixOS configuration";

  inputs = {
    deploy-rs.url = "github:serokell/deploy-rs";
    digga = { url = "github:divnix/digga"; inputs = { deploy.follows = "deploy-rs"; nixpkgs.follows = "nixpkgs"; nixlib.follows = "nixpkgs"; home-manager.follows = "home-manager"; }; };
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, digga, nixpkgs, home-manager, deploy-rs, flake-utils, nur, ... } @ inputs:
    let
      inherit (digga.lib) importHosts rakeLeaves mkDeployNodes mkHomeConfigurations mkFlake;
      inherit (flake-utils.lib) eachDefaultSystem;

      overlays = import ./overlays;
      overlay = overlays.packages;
    in
    mkFlake
      {
        inherit self inputs;

        channelsConfig = { allowUnfree = true; };
        channels = { nixpkgs = { overlays = [ nur.overlay ]; }; };


        nixos = {
          hostDefaults = { system = "x86_64-linux"; channelName = "nixpkgs"; modules = [ ./default.nix home-manager.nixosModules.home-manager ]; };
          imports = [ (importHosts ./hosts) ];
          importables = rec {
            profiles = rakeLeaves ./profiles // {
              users = rakeLeaves ./users;
            };
            suites = with profiles; rec {
              base = [ file-sync locale networking ssh vpn ] ++ users;
              users = with profiles.users; [ joel root ];
            };
          };

          hosts = {
            thinkpad-e580.modules = { profiles, ... }: { imports = with profiles; [ distributed-build ] ++ (with hardware; [ amdgpu android ]); };
          };
        };

        home = {
          importables = rec {
            profiles = rakeLeaves ./users/profiles;
            suites = with profiles; rec {
              base = [ git shell packages.tools ssh ];
              gui = base ++ [ bar browser compositor editor file-manager launcher terminal-emulator packages.apps packages.code window-manager ];
            };
          };
          users = {
            joel = { suites, ... }: { imports = suites.gui; };
            root = { suites, ... }: { imports = suites.base; };
          };
        };

        homeConfigurations = mkHomeConfigurations self.nixosConfigurations;

        deploy.nodes = mkDeployNodes self.nixosConfigurations { };

        inherit overlay overlays;

      } // (eachDefaultSystem (system:
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
        packages = import ./packages { inherit pkgs; };
      }
    ));
}
