{ pkgs, ... }:

{
	enviroment.systemPackages = with pkgs; [
		hello
	];
}


