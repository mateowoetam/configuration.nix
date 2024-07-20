This is my personal (Work in progress) NixOS configuration file

I run NixOS with Plasma 6 Wayland, with Grub, Systemd, and unfree packagess allowed installed from live ISO
(you might want to change things like the Timezone)

This are the changes I made from the default configuration.nix so far:

- I replaced Firefox with Librewolf
- I replaced `sudo` with `doas` **Remember to Change username**
- I added the [Fish](https://github.com/fish-shell/fish-shell) shell (not set as default nor login)
- I added [astfetch}(https://github.com/fastfetch-cli/fastfetch/discussions?discussions_q=packages)
- I added Git
- I added [Flakes](https://nixos.wiki/wiki/flakes) support
- I added [Vesktop](https://github.com/Vencord/Vesktop)
- I added [Steam Hardware](https://nixos.wiki/wiki/Steam) package
