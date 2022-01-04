{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ranger
    file
    python3Packages.chardet
    highlight
    unzip
    python3Packages.pdftotext
    mediainfo
    odt2txt
    ueberzug
  ];

  xdg.configFile."ranger/rc.conf".text = ''
    set preview_images_method ueberzug
  '';
}
