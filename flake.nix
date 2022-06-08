{
  description = "NixOS configuration";

  inputs = {
    deploy.url = "github:serokell/deploy-rs";
    fenix.url = "github:nix-community/fenix";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    minecraft-servers.url = "github:jyooru/nix-minecraft-servers";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nur.url = "github:nix-community/nur";
    ragenix.url = "github:yaxitech/ragenix";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
  };

  outputs = inputs:

    with inputs;
    with deploy.lib.x86_64-linux;
    with nixpkgs.lib;
    with utils.lib;

    mkFlake {
      inherit self inputs;

      supportedSystems = [ "x86_64-linux" ];

      channelsConfig = import ./profiles/common/nixpkgs.nix;
      sharedOverlays = [
        deploy.overlay
        fenix.overlay
        nur.overlay
        ragenix.overlay
        minecraft-servers.overlays.default
      ] ++ (attrValues self.overlays);

      channels.nixpkgs.patches = [
        ./patches/fix-yggdrasil.patch
        ./patches/mosh-no-firewall-open.patch
      ];

      deploy = {
        nodes = mapAttrs
          (_: configuration: {
            hostname = configuration.config.networking.fqdn;
            profiles.system.path = activate.nixos configuration;
          })
          self.nixosConfigurations;
        sshUser = "root";
      };

      hostDefaults = {
        specialArgs = {
          inherit self inputs;
          secrets = import ./secrets;
        };
        modules = [
          home-manager.nixosModule
          ragenix.nixosModules.age
        ] ++ (attrValues self.nixosModules);
      };

      hosts = import ./hosts;

      nixosModules = import ./modules;

      outputsBuilder = channels:
        let pkgs = channels.nixpkgs; in
        with pkgs;
        {
          devShells.default = mkShell {
            inherit ((import ./users/profiles/packages/code.nix { inherit pkgs; }).home) packages;
          };

          packages = import ./packages { inherit pkgs system; };
        };

      overlays = import ./overlays;

      templates = import ./templates;
    };
}
