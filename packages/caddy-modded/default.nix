{ lib, buildGoModule, ... }:
buildGoModule {
  pname = "caddy";
  version = "2.5.1";

  src = ./.;

  vendorSha256 = "sha256-WqxPA1Ro+3ktK+yWGI8aliDy7E3ZVWnH8lyaerErckw=";

  meta = with lib; {
    description = "Caddy built with caddy.listeners.proxy_protocol and dns.providers.cloudflare.";
    maintainers = with maintainers; [ jyooru ];
  };
}
