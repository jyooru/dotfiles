final: prev:
{
  minecraft = prev.minecraft.overrideAttrs (_: {
    desktopItems = [
      (final.makeDesktopItem {
        name = "minecraft-launcher";
        exec = "env DRI_PRIME=1 minecraft-launcher";
        icon = "minecraft-launcher";
        comment = "Official launcher for Minecraft, a sandbox-building game";
        desktopName = "Minecraft Launcher";
        categories = "Game;";
      })
    ];
  });

  steam = prev.steam.override { extraProfile = "export DRI_PRIME=1"; };
}
