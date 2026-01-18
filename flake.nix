{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };

  };

  outputs = { self, nixpkgs, zen-browser, ghostty, ... }:
  let
    system = "x86_64-linux";

    pkgsoverlay = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

    zen  = zen-browser.packages.${system}.default;
    ghst = ghostty.packages.${system}.default;
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        
        pkgs = pkgsoverlay;

        modules = [
          ./configuration.nix

          ({ pkgs, ... }: {
            environment.systemPackages = with pkgs; [
              zen
              ghst
            ];
          })
        ];
      };
    };
  };
}

