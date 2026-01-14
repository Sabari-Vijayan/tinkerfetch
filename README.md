# ⚡ Tinkerfetch

**Tinkerfetch** is a terminal-based "TinkerHub" themed system information tool. It's a custom-designed "skin" for the [Fastfetch](https://github.com/fastfetch-cli/fastfetch) engine.

![tinkerfetch dashboard](./screenshots/screenshot.png)

---

## ✨ Features

* **Aesthetic:** Custom-colored boxes using 8-bit ANSI escape sequences.
* **Compatibility:** Works on any Linux distribution or macOS (as long as Fastfetch is installed).

---

## 🚀 Installation

### 1. Prerequisite: Install Fastfetch

Tinkerfetch is a configuration layer for Fastfetch. You must have the core engine installed first:

* **Arch Linux:** `sudo pacman -S fastfetch`
* **Ubuntu/Debian:** `sudo apt install fastfetch`
* **Fedora:** `sudo dnf install fastfetch`
* **macOS:** `brew install fastfetch`

### 2. Run the Tinkerfetch Installer

Execute this one-liner to download the configuration, ASCII logo, and set up the `tinkerfetch` alias:
```bash
curl -sL https://raw.githubusercontent.com/Sabari-Vijayan/tinkerfetch/main/install.sh | bash
```

### 3. Usage

After installation, restart your terminal or run `source ~/.bashrc` (or `source ~/.zshrc`). Then simply type:
```bash
tinkerfetch
```

---

## 📂 Project Structure

* **config.jsonc:** The main configuration file containing the module logic and box styling.
* **logo.txt:** The custom ASCII art used in the sidebar.
* **install.sh:** Automation script for directory creation and alias setup.

---

**Created by [Sabari-Vijayan](https://github.com/Sabari-Vijayan)**
