This is my personal (Work in progress) NixOS configuration file

I run NixOS with Plasma 6 Wayland, with Grub, Systemd, and unfree packagess allowed installed from live ISO
(you might want to change things like the Timezone)

This are the changes I made from the default configuration.nix so far:

- uses Unfree software, in `./configuraiotn.nix`
- uses Plasma 6, in `./configuraiotn.nix`
- replaced Firefox with Librewolf, and configured some settings, in `./configuraiotn.nix` configured in `./home.nix`
- added Ungoogled-Chromium, Authenticator, Bitwarden, Bottles, LocalSend, Deluge, Aposrophe, Steam, ProtonPlus, Goverlay, and other tools in `./home.nix`
- replaced `sudo` with `doas` **Remember to Change username**, in `./configuraiotn.nix`
- both PulseAudio and Pipewire cofigured, in `./configuraiotn.nix`
- added Wine Stable, Staging and Wayland (optional) aswell as Winetricks, in `./home.nix`
- added Bluetooth with Blueman, in `./configuraiotn.nix`
- added and configrued the [Fish](https://github.com/fish-shell/fish-shell) shell (not set as default nor login), in `./home.nix`
- added and configured [Fastfetch](https://github.com/fastfetch-cli/fastfetch/discussions?discussions_q=packages), in `./home.nix`
- added and configured [Alacritty](https://alacritty.org/), in `./home.nix`
- added Git and wget, in `./packages.nix`
- added Flatpak support (though I think flathub isn't working), in `./configuraiotn.nix`
- added [Flakes](https://nixos.wiki/wiki/flakes) support, in `./configuration.nix`
- added [Goofcord](https://github.com/Milkshiift/GoofCord) in `./home.nix`
- added [Prism Launcher](https://prismlauncher.org), in `./home.nix` with overrides for jdk8/17/21.
- added [Steam Hardware](https://nixos.wiki/wiki/Steam) package, in `./configuraiton.nix`
- used a [Flake](https://nixos.wiki/wiki/flakes) to add [Home Manager](https://nixos.wiki/wiki/Home_Manager) in `./flake.nix`
- added ROCm support, in `./configuration.nix`
- added MangoHud, Mesa, Gamescope, and the CachyOS kernel from [Chaotic Nyx](https://www.nyx.chaotic.cx/).
- added [ollama](https://github.com/ollama/ollama) and [Alpaka](https://github.com/KDE/alpaka) to play with LLMS in `./home.nix`
- 
