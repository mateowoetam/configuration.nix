## My personal NixOS Configuration Overview (work in progress, as always)

This repo contains a **Flake-based NixOS setup** focused on a modern, private, and performant desktop experience—optimized for **Wayland**, **gaming**, **development**, and **content creation**.

---

### System & Boot

* Uses **systemd-boot**, disables GRUB.
* AMD-optimized kernel params, EFI, ACPI tweaks.
* Manages boot generations and boot-time flags.

### Networking & VPN

* `NetworkManager` with **WireGuard** and **Mullvad VPN**.
* Disables wpa\_supplicant & ModemManager.

### Audio / Input / Bluetooth

* **PipeWire** with JACK, PulseAudio, and ALSA.
* **Blueman** for Bluetooth.
* **Libinput** for touchpad.

### Display & Desktop

* **Wayland-only**, no X11.
* **SDDM** with Breeze theme + custom wallpaper.
* **KDE Plasma 6** with XWayland for legacy apps.

### Security & Users

* Uses `doas` instead of `sudo`.
* Creates user `"user"` with wide group access (networking, libvirtd, etc).

### Core Packages

* Shell tools: `fish`, `fzf`, `grc`, `tldr`, `fastfetch`.
* Browsers: `librewolf`, `ungoogled-chromium`, `mullvad-browser`.
* Media: `vlc`, `gimp-with-plugins`, `kdenlive`, `obs-studio` (VAAPI, VK).
* Dev tools: `alacritty`, `bitwarden`, `flatpak`, `ollama-rocm`, `AppImage`.
* Gaming: `steam`, `wine`, `prismlauncher`, `goverlay`, `gamemode`.

### System Services & Hardware

* Printing (CUPS), ADB, firmware updates via `fwupd`.
* Virtualization: QEMU, libvirt, OVMF, TPM, spice-vdagent.
* ROCm, DXVK, VKD3D, and **ZLUDA** (CUDA alt).

### Localization & Fonts

* Locale: `en_US.UTF-8`, Timezone: `America/Mexico_City`.
* Accessible fonts (e.g. **Atkinson Hyperlegible**).

### Nix & Home Manager

* Flakes + `nix-command` enabled.
* Pinned Home Manager `25.05`.
* Custom Home Manager setup with dotfile support.

### Environment & Shell

* Wayland-optimized env vars for Qt/Electron/Mozilla.
* Fish shell with aliases, no greeting.
* Fastfetch with custom logo and layout.

### SDDM Customization

* Applies custom wallpaper (`sddm.png`) to Breeze theme.
* Fully themed login screen with Wayland support.

## Chaotic-Nyx Enhancements (`chaotic.nix`)

* Switches to **CachyOS kernel** (`linuxPackages_cachyos`) for low-latency responsiveness.
* Installs `mangohud_git`, `gamescope_git`, and `mesa32_git` for overlays, micro-compositing, and 32-bit gaming support.
*  Optional extras (commented):

    * `chaotic.scx.enable`: Experimental CPU scheduler (SchedExt).
    * `chaotic.hdr.enable`: HDR display support.

---

### Flake Inputs

| Input                | Purpose                    |
| -------------------- | -------------------------- |
| `nixpkgs (unstable)` | Latest packages            |
| `chaotic-nyx`        | Gaming + custom modules    |
| `home-manager`       | User config                |
| `nixos-hardware`     | Zephyrus G14 (AMD) support |
| `nix-gaming`         | Gaming perf tweaks         |

---

## Goals

* Private, minimal, and reproducible setup
* Full control of system & user layers
* Gaming-ready (ROCm, Wine, Steam, etc.)
* Clean, Wayland-native desktop
