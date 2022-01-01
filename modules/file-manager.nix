{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.fileManager;
in

{
  options.modules.fileManager = {
    enable = mkEnableOption "Terminal file manager";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ranger
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
