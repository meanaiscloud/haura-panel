#!/usr/bin/env bash
set -euo pipefail

# Usage: ./scripts/import-from-bundles.sh /path/to/panel.bundle [/path/to/wings.bundle]
# Imports git bundle clones of the official Pterodactyl panel and wings repos into
# ./panel and ./wings, preserving git history. Applies minimal Haura branding to the
# panel defaults after cloning.

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Usage: $0 /path/to/panel.bundle [/path/to/wings.bundle]" >&2
  exit 1
fi

PANEL_BUNDLE="$1"
WINGS_BUNDLE="${2:-}"

PANEL_DIR="panel"
WINGS_DIR="wings"

require_file() {
  local path=$1
  if [[ -z "$path" ]]; then
    return 0
  fi
  if [[ ! -f "$path" ]]; then
    echo "File not found: $path" >&2
    exit 1
  fi
}

require_not_exists() {
  local path=$1
  if [[ -e "$path" ]]; then
    echo "Destination $path already exists; refusing to overwrite." >&2
    exit 1
  fi
}

clone_bundle() {
  local bundle=$1
  local dest=$2
  echo "[info] Cloning from bundle $bundle to $dest ..."
  git clone "$bundle" "$dest"
}

brand_panel() {
  local env_file="$PANEL_DIR/.env.example"
  local app_config="$PANEL_DIR/config/app.php"

  if [[ -f "$env_file" ]]; then
    sed -i 's/^APP_NAME=.*/APP_NAME="Haura Panel"/' "$env_file"
  fi

  if [[ -f "$app_config" ]]; then
    sed -i "s/'name' => env('APP_NAME', 'Pterodactyl'),'/'name' => env('APP_NAME', 'Haura Panel'),/" "$app_config"
  fi
}

require_file "$PANEL_BUNDLE"
require_file "$WINGS_BUNDLE"

require_not_exists "$PANEL_DIR"
require_not_exists "$WINGS_DIR"

clone_bundle "$PANEL_BUNDLE" "$PANEL_DIR"
brand_panel

if [[ -n "$WINGS_BUNDLE" ]]; then
  clone_bundle "$WINGS_BUNDLE" "$WINGS_DIR"
fi

echo "Imported panel${WINGS_BUNDLE:+ and wings} from bundles with Haura defaults applied."
