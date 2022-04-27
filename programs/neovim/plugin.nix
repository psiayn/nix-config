with builtins;
plugin: config: {
  inherit plugin;
  optional = true;
  config = concatStringsSep " " [
    ":packadd"
    plugin.pname
    "\n"
    config
  ];
}
