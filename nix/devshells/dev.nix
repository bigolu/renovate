{ perSystem, inputs, ... }:
perSystem.devshell.mkShell (
  { extraModulesPath, pkgs, ... }:
  {
    imports = [
      "${extraModulesPath}/locale.nix"
      perSystem.self.renovate.devshellModule
    ]
    ++ (with inputs.devshell-modules.devshellModules; [
      minimal
      autocomplete
      state
      gcRoot
    ]);

    gcRoot.roots.flake.inputs = inputs;

    devshell.packages = with pkgs; [
    ];
  }
)
