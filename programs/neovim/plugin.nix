with builtins;
plugin: config: {
  inherit plugin;
  config = concatStringsSep " " [
    ":packadd"
    plugin.pname
    "\n"
    config
  ];
}
