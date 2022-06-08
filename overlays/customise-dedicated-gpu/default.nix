_final: prev:
{
  polymc = prev.polymc.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      sed -i "s/Exec=/Exec=env DRI_PRIME=1 /" $out/share/applications/org.polymc.PolyMC.desktop
    '';
  });

  steam = prev.steam.override { extraProfile = "export DRI_PRIME=1"; };
}
