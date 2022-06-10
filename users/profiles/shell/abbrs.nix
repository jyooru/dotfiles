{
  programs.fish.shellAbbrs = {
    c = "code";
    d = "ddgr";
    m = "mosh";
    py = "python";
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
    gc = "git commit";
    gca = "git commit --amend";
    gch = "git checkout";
    gcl = "git clone";
    gcld = "git clone --depth 1";
    gclm = "git clone --mirror";
    gcp = "git cherry-pick";
    gd = "git diff";
    gf = "git fetch";
    gi = "git init";
    gl = "git log --graph --oneline --decorate";
    glf = "git log --pretty=fuller";
    glo = "git log --pretty=oneline";
    gm = "git merge --no-ff";
    gp = "git push";
    gpf = "git push --force";
    gpl = "git pull";
    gr = "git rebase";
    grs = "git reset --hard";
    gs = "git status";
    gu = "git reset --soft HEAD^"; # git undo

    f = "ipfs";
    fa = "ipfs add";
    fc = "ipfs cat";
    fdn = "ipfs dns";
    fdr = "ipfs dht findpeer";
    fdv = "ipfs dht findprovs";
    fl = "ipfs ls";
    fr = "ipfs resolve";
    fsb = "ipfs stats bw";
    fsh = "ipfs stats repo -H";

    n = "nix";
    nb = "nix build";
    nd = "nix develop";
    nf = "nix flake";
    nfc = "nix flake check";
    nfl = "nix flake lock";
    nfi = "nix flake init -t github:jyooru/dotfiles#";
    nfu = "nix flake update";
    nr = "nix run";
    ns = "nix shell nixpkgs#";

    no = "nixos-rebuild";
    nos = "sudo nixos-rebuild switch";
    nosd = "sudo nixos-rebuild switch && sudo deploy";
    nob = "nixos-rebuild build";
  };
}
