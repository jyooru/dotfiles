{
  imports = [
    ../base

    ../../profiles/nodes/alfis
    ../../profiles/nodes/ipfs
    ../../profiles/networks/yggdrasil
  ];

  services.ipfs.extraConfig.Experimental.AcceleratedDHTClient = true;

  users.users = {
    joel.openssh.authorizedKeys.keyFiles = [
      ../../hosts/thinkpad-e580/keys/ssh-joel.pub
      ../../hosts/thinkpad-e580/keys/ssh-root.pub
    ];
    root.openssh.authorizedKeys.keyFiles = [
      ../../hosts/thinkpad-e580/keys/ssh-root.pub
    ];
  };
}
