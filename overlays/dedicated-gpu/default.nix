self: super:
{
  minecraft = super.minecraft.overrideAttrs (_: {
    desktopItems = [
      (self.makeDesktopItem {
        name = "minecraft-launcher";
        exec = "env DRI_PRIME=1 minecraft-launcher";
        icon = "minecraft-launcher";
        comment = "Official launcher for Minecraft, a sandbox-building game";
        desktopName = "Minecraft Launcher";
        categories = "Game;";
      })
    ];
  });

  steam = super.steam.override { extraProfile = "export DRI_PRIME=1"; };
}
