{ lib, buildGoModule, ... }:
buildGoModule {
  pname = "caddy";
  version = "2.4.6";

  src = ./.;

  vendorSha256 = "0kjw5lrmb052v1kryk6s3vqbv48n75i45488j35gbjya90qm5wyw";

  meta = with lib; {
    description = "Caddy built with caddy.listeners.proxy_protocol and dns.providers.cloudflare.";
    maintainers = with maintainers; [ jyooru ];
  };
}
