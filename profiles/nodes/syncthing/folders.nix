let
  all = [ "thinkpad-e580" "portege-r700-a" "portege-r700-b" "portege-z930" "ga-z77-d3h" ];
  backup = [ "thinkpad-e580" "portege-r700-a" "ga-z77-d3h" ];

  all' = all ++ [ "galaxy-a22" ];
  backup' = backup ++ [ "galaxy-a22" ];
in

{
  "archive" = { devices = backup'; id = "u4tsv-7hxb7"; };
  "cluster" = { devices = all; id = "jyxof-ssssq"; };
  "code" = { devices = all; id = "wcqyy-zrab5"; };
  "data" = { devices = backup'; id = "n3a2w-sqney"; };
  "documents" = { devices = backup'; id = "pgpew-tged2"; };
  "games" = { devices = backup; id = "xt4t4-d2jad"; };
  "media" = { devices = backup; id = "kasul-jsgfj"; };
  "media/phone" = { devices = backup'; id = "xkgdh-rrx6u"; };
  "notes" = { devices = backup'; id = "bc6qz-tad4c"; };
  "school" = { devices = backup'; id = "s6jde-csrow"; };
  "tmp" = { devices = all'; id = "5f6yn-csxu7"; };
}
