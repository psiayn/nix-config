# Nix Config

My nix config that uses home-manager and flakes. So it requires nix flakes enabled.

## How to use
Rename psiayn to whatever username you want.
Refer to [this](https://nix-community.github.io/home-manager/index.html#ch-nix-flakes) for more details.

### Inital
```sh
nix build --no-link .#homeConfigurations.psiayn.activationPackage
 "$(nix path-info .#homeConfigurations.psiayn.activationPackage)"/activate
```

### Following builds
```sh
home-manager switch --flake .#psiayn
```
