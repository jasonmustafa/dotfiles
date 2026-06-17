#!/usr/bin/env bash
# Install pacman + AUR packages from the synced pkglists.
# Idempotent: --needed skips already-installed packages.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKGLIST="$SCRIPT_DIR/pkglist.txt"
AURLIST="$SCRIPT_DIR/foreignpkglist.txt"

msg() { printf '\n\033[1;34m==>\033[0m %s\n' "$*"; }

# 1. Enable multilib (required for Steam + lib32-* packages).
if ! grep -q '^\[multilib\]' /etc/pacman.conf; then
  msg "enabling [multilib] in /etc/pacman.conf"
  sudo sed -i '/^#\[multilib\]/,/^#Include/ s/^#//' /etc/pacman.conf
  sudo pacman -Sy
fi

# 2. Sync official-repo packages.
msg "installing $(wc -l <"$PKGLIST") official packages"
sudo pacman -S --needed --noconfirm - <"$PKGLIST"

# 3. Bootstrap paru from AUR if missing.
if ! command -v paru >/dev/null 2>&1; then
  msg "bootstrapping paru from AUR"
  tmp=$(mktemp -d)
  trap 'rm -rf "$tmp"' EXIT
  git clone https://aur.archlinux.org/paru.git "$tmp/paru"
  (cd "$tmp/paru" && makepkg -si --noconfirm)
fi

# 4. Sync AUR packages.
msg "installing $(wc -l <"$AURLIST") AUR packages"
paru -S --needed --noconfirm - <"$AURLIST"

msg "done. next: see 'Bootstrap from Dotfiles' in the Arch Setup note."
