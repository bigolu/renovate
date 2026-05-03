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
    ]);

    devshell.packages = [perSystem.self.default] ++ (with pkgs; [
      # For the `run` steps in CI workflows
      bash
    ]);
  }
)
