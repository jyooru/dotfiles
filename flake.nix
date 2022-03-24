{
  description = "NixOS configuration";

  inputs = {
    comma.url = "github:nix-community/comma";
    deploy.url = "github:serokell/deploy-rs";
    fenix.url = "github:nix-community/fenix";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nur.url = "github:nix-community/nur";
    ragenix.url = "github:yaxitech/ragenix";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
  };

  outputs = { self, comma, deploy, fenix, home-manager, nixpkgs, nur, ragenix, utils, ... } @ inputs:

    with deploy.lib.x86_64-linux;
    with nixpkgs.lib;
    with utils.lib;

    mkFlake {
      inherit self inputs;

      supportedSystems = [ "x86_64-linux" ];

      channelsConfig = import ./profiles/common/nixpkgs.nix;
      sharedOverlays = [
        (final: _: { comma = import comma { pkgs = final; }; })
        deploy.overlay
        fenix.overlay
        nur.overlay
        ragenix.overlay
      ] ++ (attrValues self.overlays);
      channels.nixpkgs.patches = [
        ./patches/163701.patch
        ./patches/fix-yggdrasil.patch
      ];

      hostDefaults = {
        specialArgs = rec {
          inherit self inputs;
          profiles = import ./profiles { inherit utils; };
          users = import ./users { inherit utils; };
          secrets = import ./secrets;
          suites = with profiles; {
            base = [ common file-sync locale networking users.joel users.root ssh vpn ];
            server = suites.base ++ [ server ];
          };
        };
        modules = [
          home-manager.nixosModule
          ragenix.nixosModules.age
        ];
      };
      hosts = import ./hosts { inherit utils; };
      deploy = {
        nodes = mapAttrs
          (_: configuration: {
            hostname = configuration.config.networking.fqdn;
            profiles.system.path = activate.nixos configuration;
          })
          self.nixosConfigurations;

        sshUser = "root";
      };

      outputsBuilder = channels:
        let pkgs = channels.nixpkgs; in
        with pkgs; {
          devShell = mkShell {
            packages = [
              nixpkgs-fmt
              nodePackages.node2nix
              qtile
            ]
            ++ (import ./users/profiles/packages/code.nix { inherit pkgs; }).home.packages;
          };

          packages = import ./packages { inherit pkgs system; };
        };

      templates = import ./templates;

      overlays = import ./overlays;
      overlay = self.overlays.packages;

      ci = with builtins; with self; {
        devShell = devShell.${currentSystem};
        nixosConfigurations = recurseIntoAttrs (mapAttrs (_: value: value.config.system.build.toplevel) nixosConfigurations);
        overlays = import ./overlays/ci.nix { inherit inputs; };
        packages = recurseIntoAttrs packages.${currentSystem};
      };
    };
}
