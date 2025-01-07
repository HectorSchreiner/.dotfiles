{

  description = "My flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    ghostty.url ="github:ghostty-org/ghostty";
  };

  outputs = { self, nixpkgs, ghostty, zen-browser, ...}:
    let
	lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
	   ./configuration.nix 
	];
      };
    };
  };

}
