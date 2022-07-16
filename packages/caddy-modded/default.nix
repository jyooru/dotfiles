{ lib, buildGoModule, ... }:
buildGoModule {
  pname = "caddy";
  version = "2.5.2";

  src = ./.;

  vendorSha256 = "sha256-hZzrKKh6JzGhnl2/KdPOGGVfkbK7P6vTB7r+h1d10zQ=";

  meta = with lib; {
    description = "Caddy built with dns.providers.cloudflare.";
    maintainers = with maintainers; [ jyooru ];
  };
}
