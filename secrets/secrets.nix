with builtins;

let
  flake = getFlake (toString ../.);
  hosts = map (host: replaceStrings [ "${host}.joel.tokyo " ] [ "" ] (readFile (../hosts + "/${host}/keys/ssh.pub"))) (attrNames flake.nixosConfigurations);
in

{
  # tls {
  #   dns cloudflare "xxx"
  # }
  "tls-joel.tokyo.age".publicKeys = hosts;
}
