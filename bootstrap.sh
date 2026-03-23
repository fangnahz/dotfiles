#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_SRC_DIR="$DOTFILES_DIR/config"
CONFIG_DST_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

mkdir -p "$CONFIG_DST_DIR"
mkdir -p "$BACKUP_DIR"

log() {
    printf '%s\n' "$1"
}

backup_path() {
    local src_path="$1"
    local rel_name="$2"
    mkdir -p "$(dirname "$BACKUP_DIR/$rel_name")"
    mv "$src_path" "$BACKUP_DIR/$rel_name"
}

link_item() {
    local src="$1"
    local dst="$2"
    local backup_name="$3"

    if [[ ! -e "$src" && ! -L "$src" ]]; then
        log "Skip: source does not exist: $src"
        return
    fi

    if [[ -L "$dst" ]]; then
        local current_target
        current_target="$(readlink "$dst")"
        if [[ "$current_target" == "$src" ]]; then
            log "OK: already linked: $dst -> $src"
            return
        else
            log "Remove old symlink: $dst -> $current_target"
            rm "$dst"
        fi
    elif [[ -e "$dst" ]]; then
        log "Backup: $dst -> $BACKUP_DIR/$backup_name"
        backup_path "$dst" "$backup_name"
    fi

    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    log "Linked: $dst -> $src"
}

# Link config directories under ~/.config
if [[ -d "$CONFIG_SRC_DIR" ]]; then
    for src in "$CONFIG_SRC_DIR"/*; do
        [[ -e "$src" ]] || continue
        name="$(basename "$src")"
        dst="$CONFIG_DST_DIR/$name"
        link_item "$src" "$dst" ".config/$name"
    done
fi

# Link top-level dotfiles
link_item "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig" ".gitconfig"
link_item "$DOTFILES_DIR/vimrc" "$HOME/.vimrc" ".vimrc"
link_item "$DOTFILES_DIR/zshrc" "$HOME/.zshrc" ".zshrc"

log ""
log "Done."
log "Backups, if any, are in: $BACKUP_DIR"
