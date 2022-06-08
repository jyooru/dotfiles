{
  programs.fish.shellAbbrs = {
    c = "code";
    d = "ddgr";
    m = "mosh";
    py = "python";
    pym = "python -m";
    r = "ranger";
    o = "xdg-open";
    open = "xdg-open";

    a = "ip -br -c a";
    get-class = "xprop | grep WM_CLASS | awk '{print $4}'";
    temp = "watch -n 1 sensors";
    wifi-scan = "nmcli dev wifi list --rescan yes";

    l = "lsd";
    la = "lsd -A";
    ll = "lsd -Al";

    "-" = "cd -";

    g = "git";
    ga = "git add";
    gaa = "git add --all";
    gbu = "git branch --set-upstream-to=origin/";
    gb = "git checkout -b";
    gbb = "git branch";
    gbd = "git branch -d";
    gbD = "git branch -D";
    gbm = "git branch -m";
    gbpd = "git checkout main || git checkout master && git pull && git branch -d"; # git branch pull delete
    gc = "git commit";
    gca = "git commit --amend";
    gch = "git checkout";
    gcl = "git clone";
    gd = "git diff";
    gf = "git fetch";
    gi = "git init";
    gl = "git log --graph --oneline --decorate";
    glf = "git log --pretty=fuller";
    glo = "git log --pretty=oneline";
    gm = "git merge --no-ff";
    gp = "git push";
    gpl = "git pull";
    gps = "git push";
    gpsf = "git push --force";
    gr = "git remote";
    grb = "git rebase";
    grp = "git remote prune";
    grpo = "git remote prune origin";
    grs = "git reset --hard";
    gs = "git status";
    gst = "git stash";
    gstp = "git stash pop";
    gu = "git reset --soft HEAD^"; # git undo

    f = "ipfs";
    fa = "ipfs add";
    fc = "ipfs cat";
    fccb = "ipfs config Swarm.ConnMgr.Type basic";
    fccc = "sudo chmod g+r /var/lib/ipfs/config";
    fccn = "ipfs config Swarm.ConnMgr.Type none";
    fd = "ipfs dns";
    fl = "ipfs ls";
    fr = "ipfs resolve";
    fsb = "ipfs stats bw";
    fsh = "ipfs stats repo -H";

    n = "nix";
    nb = "nix build";
    nbb = "nix build .";
    nbn = "nix build nixpkgs#";
    nd = "nix develop";
    nf = "nix flake";
    nfc = "nix flake check";
    nfl = "nix flake lock";
    nfi = "nix flake init -t github:jyooru/dotfiles#";
    nfu = "nix flake update";
    np = "nix-prefetch-url";
    nr = "nix run";
    nrr = "nix run .";
    ns = "nix shell nixpkgs#";

    no = "nixos-rebuild";
    nos = "sudo nixos-rebuild switch";
    nosd = "sudo nixos-rebuild switch && sudo deploy";
    nob = "nixos-rebuild build";

    nff = "nixpkgs-fmt";
    nfff = "nixpkgs-fmt .";
    npr = "nixpkgs-review pr";
    nprp = "nixpkgs-review post-result";
  };
}
