{ perSystem, inputs, ... }:
perSystem.devshell.mkShell (
  { extraModulesPath, pkgs, ... }:
  {
    imports = [
      "${extraModulesPath}/locale.nix"
    ]
    ++ (with inputs.devshell-modules.devshellModules; [
      minimal
      state
      gcRoot
    ]);

    gcRoot = {
      roots.flake.inputs = inputs;
      diff.enable = false;
    };

    devshell.packages = [perSystem.self.default] ++ (with pkgs; [
      jq
      # For the `run` steps in CI workflows
      bash
    ]);
  }
)
