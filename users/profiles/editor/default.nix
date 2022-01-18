{ pkgs, ... }:
{
  imports = [ ./keybindings.nix ./settings.nix ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # ahmadalli.vscode-nginx-conf
      eamodio.gitlens
      # enkia.tokyo-night
      esbenp.prettier-vscode
      # GitHub.github-vscode-theme
      # GitHub.remotehub
      # GitHub.vscode-pull-request-github
      # icrawl.discord-vscode
      jnoortheen.nix-ide
      # miguelsolorio.min-theme
      ms-azuretools.vscode-docker
      ms-python.python
      ms-python.vscode-pylance
      ms-toolsai.jupyter
      # ms-vscode-remote.remote-containers
      # ms-vscode.live-server
      naumovs.color-highlight
      # PeterStaev.lego-spikeprime-mindstorms-vscode
      # PKief.material-icon-theme
      # pranaygp.vscode-css-peek
      # raynigon.nginx-formatter
      # redhat.vscode-commons
      # redhat.vscode-xml
      redhat.vscode-yaml
      # rust-lang.rust
      timonwong.shellcheck
      yzhang.markdown-all-in-one
    ];
  };
}
