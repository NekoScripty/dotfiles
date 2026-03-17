<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=auto&height=60&section=footer&invert=true&animation=twinkling" width="100%" />
</p>

<h1 align="center">🌑 OBSIDIAN</h1>
<p align="center">
  <strong>A Formal Black BSPWM environment engineered for focus and fluidity.</strong>
  <br />
  <i>Bridging the gap between X11 stability and modern Wayland aesthetics.</i>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/License-GPLv3-000000?style=for-the-badge" />
  <img src="https://img.shields.io/badge/WM-bspwm-000000?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Distro-Arch-000000?style=for-the-badge" />
</p>

---

## 📸 Visual Showcase

<div align="center">
  <table border="0" cellspacing="5" cellpadding="5">
    <tr>
      <td width="50%"><img src="Assets/1.png" alt="Clean Desktop" style="border-radius: 8px;"></td>
      <td width="50%"><img src="Assets/2.png" alt="Power Menu" style="border-radius: 8px;"></td>
    </tr>
    <tr>
      <td width="50%"><img src="Assets/3.png" alt="Rofi Launcher" style="border-radius: 8px;"></td>
      <td width="50%"><img src="Assets/4.png" alt="Code Environment" style="border-radius: 8px;"></td>
    </tr>
  </table>
</div>

---

## 🎨 Design Philosophy
Unlike static setups, **Obsidian** treats the desktop as a living workspace. Every shadow, transition, and border is calculated to provide a high-density, professional experience.

* **Palette:** Deep Obsidian (`#000000`) paired with Crisp Slate (`#B0B3B8`).
* **Compositor:** Custom `picom` build featuring `dual_kawase` blurring and slide-in workspace transitions.
* **Typography:** `JetBrainsMono Nerd Font` for surgical technical clarity.

---

## 🛠️ The Internal API
The heart of this rice lies in `.config/bspwm/scripts/`. These aren't just scripts; they are the engine.

> [!IMPORTANT]
> **Modular Infrastructure:** The system automatically detects if you are on a **Desktop** (`config.ini`) or **Laptop** (`configLAP.ini`), adjusting battery modules and backlight controls instantly.

* **`screen.sh`** 🖥️ – CLI-guided display management with strict resolution validation.
* **`wall.sh`** 🖼️ – A Rofi-powered wallpaper engine with a 4x4 visual preview grid.
* **`log.sh`** ⚡ – A borderless, minimalist power menu using high-fidelity iconography.

---

## ⌨️ Workflow Essentials

| Action | Keybinding |
| :--- | :--- |
| **Terminal (Kitty)** | `Super + T` |
| **App Launcher** | `Super + R` |
| **Wallpaper Grid** | `Super + W` |
| **Power Menu** | `Super + N` |
| **Kill Window** | `Super + Q` |

---

## 📥 Getting Started

### 1. Clone & Prep
```bash
git clone [https://github.com/NekoScripty/Dotfiles.git](https://github.com/NekoScripty/Dotfiles.git)
cd Dotfiles
