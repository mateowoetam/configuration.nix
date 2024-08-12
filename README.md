This is my personal (Work in progress) NixOS configuration file

I run NixOS with Plasma 6 Wayland, with Grub, Systemd, and unfree packagess allowed installed from live ISO
(you might want to change things like the Timezone)

This are the changes I made from the default configuration.nix so far:

- replaced Firefox with Librewolf, and configured some settings, in `./packages.nix` configured in `./home.nix`
- replaced `sudo` with `doas` **Remember to Change username**, in `./superuser.nix`
- added and configrued the [Fish](https://github.com/fish-shell/fish-shell) shell (not set as default nor login), in `./home.nix`
- added and configured [Fastfetch](https://github.com/fastfetch-cli/fastfetch/discussions?discussions_q=packages), in `./home.nix`
- added and configured [Alacritty](https://alacritty.org/), in `./home.nix`
- added Git and wget, in `./packages.nix`
- added Flatpak support (though I think flathub isn't working), in `./flatpak.nix`
- added [Flakes](https://nixos.wiki/wiki/flakes) support, in `./flakes.nix`
- added [Vesktop](https://github.com/Vencord/Vesktop) in `./home.nix`
- added [Prism Launcher](https://prismlauncher.org), in `./home.nix`
- added [Steam Hardware](https://nixos.wiki/wiki/Steam) package, in `./steam-hardware.nix`
- used a [Flake](https://nixos.wiki/wiki/flakes) to add [Home Manager](https://nixos.wiki/wiki/Home_Manager) in `/flake.nix`
- added my custom Halmak Keyboard layotu into the system (though it needs some work), in `./keyboard.nix`
- added ROCm support, in `./rocm.nix`
- used [Stylix](https://stylix.dev/https://stylix.dev/) to theme the entire system to Catppuccin, in `./stylinx.nix`
