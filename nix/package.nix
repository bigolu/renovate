{ perSystem, pkgs, ... }:
let
  inherit (pkgs) writeTextFile bash;
  inherit (pkgs.lib) getExe makeBinPath concatMapAttrsStringSep fileContents;

  pname = "bigolu-renovate";

  regenerate-gomod2nix-lock = pkgs.writeShellApplication {
    name = "regenerate-gomod2nix-lock";
    runtimeInputs = [ perSystem.gomod2nix.default ];
    text = ''
      go_mod_directory="$1"

      if [[ -e $go_mod_directory/gomod2nix.toml ]]; then
        gomod2nix --dir "$go_mod_directory" generate --with-deps
      fi
    '';
  };

  dependencies = with pkgs; [
    renovate
    # Needed by Renovate
    git
    # For the values "gomodTidy" and "gomodUpdateImportPaths" of the Renovate
    # config setting "postUpdateOptions".
    go
    # For a Renovate "postUpgradeTask"
    regenerate-gomod2nix-lock
    # For the value "gomodUpdateImportPaths" of the Renovate config setting "postUpdateOptions".
    mod
  ];

  env = {
    RENOVATE_CONFIG_FILE = ../global.json;
    PATH = ''"${makeBinPath dependencies}:$PATH"'';
  };
in
writeTextFile {
  name = "${pname}";
  executable = true;
  destination = "/bin/${pname}";

  text = ''
    #!${getExe bash}

    ${concatMapAttrsStringSep "\n" (name: value: "export ${name}=${value}") env}

    ${fileContents ../renovate.bash}
  '';

  passthru.devshellModule = { devshell.packages = [bash] ++ dependencies; };
}
