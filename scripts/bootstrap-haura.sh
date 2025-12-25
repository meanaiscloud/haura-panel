#!/usr/bin/env bash
set -euo pipefail

PANEL_REPO="https://github.com/pterodactyl/panel.git"
WINGS_REPO="https://github.com/pterodactyl/wings.git"
PANEL_DIR="panel"
WINGS_DIR="wings"

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "[error] Required command '$1' is not installed." >&2
    exit 1
  fi
}

clone_repo() {
  local repo_url=$1
  local target_dir=$2
  if [ -d "$target_dir/.git" ]; then
    echo "[info] '$target_dir' already exists; skipping clone."
  else
    echo "[info] Cloning $repo_url into $target_dir ..."
    git clone --depth=1 "$repo_url" "$target_dir"
  fi
}

brand_panel() {
  local env_file="$PANEL_DIR/.env.example"
  if [ -f "$env_file" ]; then
    echo "[info] Setting default app name to 'Haura Panel' in $env_file"
    sed -i "s/^APP_NAME=.*/APP_NAME=Haura Panel/" "$env_file"
  else
    echo "[warn] $env_file not found; branding step skipped."
  fi
}

main() {
  require_cmd git
  require_cmd sed

  clone_repo "$PANEL_REPO" "$PANEL_DIR"
  clone_repo "$WINGS_REPO" "$WINGS_DIR"

  brand_panel

  echo "[done] Upstream sources cloned. Next: customize branding assets and follow install docs within each directory."
}

main "$@"
