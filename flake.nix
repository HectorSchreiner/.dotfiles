{
  description = "My NixOS configuration with Zen Browser, HyprPanel & Ghostty";

  inputs = {
    # Main Nixpkgs (unstable)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Zen Browser flake
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # HyprPanel flake (overlay)
    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
    };

    # Ghostty flake
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };

  };

  outputs = { self, nixpkgs, zen-browser, hyprpanel, ghostty, ... }:
  let
    system = "x86_64-linux";

    # Instantiate nixpkgs with allowUnfree and the HyprPanel overlay
    pkgsoverlay = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
      overlays = [ hyprpanel.overlay ];
    };

    # Pull Zen Browser & Ghostty from their flakes
    zen  = zen-browser.packages.${system}.default;
    ghst = ghostty.packages.${system}.default;
  in {
    nixosConfigurations = {
      # Must match your hostname ("nixos")
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        
        # Use the overlaid pkgs so hyprpanel is available
        pkgs = pkgsoverlay;

        modules = [
          ./configuration.nix

          # Inline module to add extra packages
          ({ pkgs, ... }: {
            environment.systemPackages = with pkgs; [
              hyprpanel
              zen
              ghst
            ];
          })
        ];
      };
    };
  };
}

