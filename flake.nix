{
  description = "NixOS configuration";

  inputs = {
    deploy-rs.url = "github:serokell/deploy-rs";
    digga = { url = "github:Pacman99/digga/customBuilds-mkDefault"; inputs = { deploy.follows = "deploy-rs"; nixpkgs.follows = "nixpkgs"; nixlib.follows = "nixpkgs"; home-manager.follows = "home-manager"; }; };
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, digga, nixpkgs, home-manager, deploy-rs, flake-utils, nur, nixos-hardware, ... } @ inputs:
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
            overlays = [ (builtins.attrValues overlays) nur.overlay ];
            patches = [
              (builtins.fetchurl {
                # https://github.com/NixOS/nixpkgs/pull/156974
                url = "https://github.com/NixOS/nixpkgs/pull/156974.patch";
                sha256 = "0npxb36ic5g360wjjjsis9shj7niyj7s7mggmp7bgiagjlj9rv9l";
              })
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
              server' = server ++ [ ci ];
            };
          };

          hosts = with nixos-hardware.nixosModules; {
            ga-z77-d3h.modules = { suites, ... }: { imports = suites.server'; };
            portege-r700-a.modules = { suites, ... }: { imports = suites.server; };
            portege-r700-b.modules = { suites, ... }: { imports = suites.server; };
            portege-z930.modules = { suites, ... }: { imports = suites.server'; };
            thinkpad-e580.modules = { profiles, ... }: { imports = [ common-cpu-intel common-gpu-amd common-pc-laptop common-pc-laptop-ssd ] ++ (with profiles; [ distributed-build hardware.android ]); };
          };
        };

        home = {
          importables = rec {
            profiles = rakeLeaves ./users/profiles;
            suites = with profiles; rec {
              base = [ git shell packages.tools ssh ];
              gui = base ++ [ browser compositor editor file-manager launcher terminal-emulator packages.apps packages.code window-manager ];
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

      } // (flake-utils.lib.eachSystem supportedSystems (system:
      let pkgs = import nixpkgs { inherit system; }; in
      with pkgs;
      rec {
        devShell = mkShell {
          packages = [ nixpkgs-fmt deploy-rs.outputs.packages.${system}.deploy-rs qtile nodePackages.node2nix ]
          ++ (import ./users/profiles/packages/code.nix { inherit pkgs; }).home.packages;
        };

        legacyPackages = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
        packages = import ./packages { inherit pkgs; };
      }
    ));
}
