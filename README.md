# 🌑 Obsidian.sh
### A Professional, Minimalist BSPWM Environment for Arch Linux

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg?style=flat-square)](https://www.gnu.org/licenses/gpl-3.0)
[![WM: bspwm](https://img.shields.io/badge/WM-bspwm-lightgrey?style=flat-square)](https://github.com/baskerville/bspwm)
[![Animations: Picom](https://img.shields.io/badge/Animations-Hyprland--Style-595959?style=flat-square)](https://github.com/FTLabs/picom)

**Obsidian** is a curated "Formal Black" development environment built for focus and fluidity. While many X11 setups feel static, this rice utilizes custom animation logic and a suite of dedicated shell-scripts (the "Internal API") to bridge the gap between classic stability and modern Wayland-tier aesthetics.

---

## 🎨 Design Language
* **Palette:** Deep Obsidian (`#000000`) paired with Crisp Slate (`#B0B3B8`). 
* **Compositor:** Custom `picom` configuration featuring `dual_kawase` blurring and slide-in workspace transitions.
* **Typography:** `JetBrainsMono Nerd Font` for technical clarity.
* **UX:** Dynamic 1px borders and minimal gaps for a tight, high-density professional workspace.

---

## ⚙️ The Script API
This rice is driven by a suite of custom automation tools located in `.config/bspwm/`:

* **`screen.sh`**: A robust, CLI-guided display management tool with strict validation for resolution, refresh rates, and rotation.
* **`wall.sh`**: A GUI-based wallpaper engine that generates a **4x4 visual grid** using Rofi for instant theme switching.
* **`log.sh`**: A borderless, minimalist power menu using high-fidelity `.png` iconography.

---

## ⌨️ Essential Workflow
Keybindings are handled by `sxhkd`. The logic is grouped by "System", "Media", and "Navigation".

| Action | Keybinding |
| :--- | :--- |
| **Primary Terminal (Kitty)** | `Super + T` |
| **App Launcher (Rofi)** | `Super + R` |
| **Wallpaper Grid Selector** | `Super + W` |
| **Power Menu** | `Super + N` or `F10` |
| **Close Window** | `Super + Q` |
| **Toggle Floating** | `Super + Space` |
| **System Resource Monitor** | `F5` |

---

## 🔋 Modular Infrastructure
The configuration is split to support both high-end desktops and portable machines:

* **Desktop (`config.ini`)**: Optimized for static network setups and multi-monitor layouts.
* **Laptop (`configLAP.ini`)**: Features dynamic battery ramps (`` to ``) and backlight control modules.
* **Compositor**: Glx-backend optimized for NVIDIA/Intel to ensure tear-free animations.

---
