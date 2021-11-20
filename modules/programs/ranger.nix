{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.programs.ranger;
in

{
  options.modules.programs.ranger = {
    enable = mkEnableOption "Terminal file manager";
    optionalDependencies = mkOption {
      type = types.bool;
      default = true;
      description = "Install optional dependencies for ranger";
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ ranger ] ++ lib.optionals cfg.optionalDependencies [
      file
      python3Packages.chardet
      highlight
      unzip
      python3Packages.pdftotext
      mediainfo
      odt2txt
    ];
  };
}
