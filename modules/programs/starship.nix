{ config, lib, ... }:

with lib;

let
  cfg = config.modules.programs.starship;
in

{
  options.modules.programs.starship = {
    enable = mkEnableOption "Shell prompt";
  };
  config = mkIf cfg.enable {
    home-manager.users.joel.programs.starship = {
      enable = true;
      settings = {
        aws = { symbol = "  "; };
        conda = { symbol = " "; };
        dart = { symbol = " "; };
        directory = { read_only = " "; };
        docker_context = { symbol = " "; };
        elixir = { symbol = " "; };
        elm = { symbol = " "; };
        git_branch = { symbol = " "; };
        golang = { symbol = " "; };
        hg_branch = { symbol = " "; };
        java = { symbol = " "; };
        julia = { symbol = " "; };
        memory_usage = { symbol = " "; };
        nim = { symbol = " "; };
        nix_shell = { symbol = " "; };
        package = { symbol = " "; };
        perl = { symbol = " "; };
        php = { symbol = " "; };
        python = { symbol = " "; };
        ruby = { symbol = " "; };
        rust = { symbol = " "; };
        scala = { symbol = " "; };
        shlvl = { symbol = " "; };
        swift = { symbol = "ﯣ "; };
      };
    };
  };
}
