{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nix-snapd.url = "github:nix-community/nix-snapd";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
  };

  outputs = { self, nixpkgs, zen-browser, ghostty, nix-snapd, spicetify-nix, ... }:
  let
    system = "x86_64-linux";

    pkgsoverlay = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

    zen  = zen-browser.packages.${system}.default;
    ghst = ghostty.packages.${system}.default;
    
    # Define spicePkgs here so it's accessible inside your inline module
    spicePkgs = spicetify-nix.legacyPackages.${system};
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        
        pkgs = pkgsoverlay;

        modules = [
          ./configuration.nix
          nix-snapd.nixosModules.default { services.snap.enable = true; }
          
          # 1. Import the Spicetify NixOS module
          spicetify-nix.nixosModules.default

          ({ pkgs, ... }: {
            environment.systemPackages = with pkgs; [
              zen
              ghst
            ];

            # 2. Configure Spicetify
            programs.spicetify = {
              enable = true;

              enabledExtensions = with spicePkgs.extensions; [
                adblock
                hidePodcasts
                shuffle
              ];
              
              enabledCustomApps = with spicePkgs.apps; [
                newReleases
                ncsVisualizer
              ];
              
              enabledSnippets = with spicePkgs.snippets; [
                rotatingCoverart
                pointer
              ];

              theme = spicePkgs.themes.onepunch;
            };
          })
        ];
      };
    };
  };
}
