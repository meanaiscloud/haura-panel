#!/usr/bin/env bash
set -euo pipefail

PANEL_REPO="https://github.com/pterodactyl/panel.git"
WINGS_REPO="https://github.com/pterodactyl/wings.git"

PANEL_DIR="panel"
WINGS_DIR="wings"

usage() {
  cat <<USAGE
Usage: $0 [options]

One-shot importer for real Pterodactyl sources with Haura defaults applied.
Provide local archives or git bundles to avoid network access, or enable
--allow-git-clone to pull directly from GitHub when outbound access exists.

Options:
  --panel-archive PATH   Tar.gz archive of the Pterodactyl panel release.
  --wings-archive PATH   Tar.gz archive of the Pterodactyl wings release.
  --panel-bundle PATH    Git bundle of the panel repository (preserves history).
  --wings-bundle PATH    Git bundle of the wings repository (preserves history).
  --allow-git-clone      Permit cloning from upstream if no archive/bundle given.
  -h, --help             Show this help message.

Examples:
  $0 --panel-archive ./panel.tar.gz --wings-archive ./wings.tar.gz
  $0 --panel-bundle ./panel.bundle --wings-bundle ./wings.bundle
  $0 --allow-git-clone   # uses network cloning for both panel and wings
USAGE
}

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "[error] Required command '$1' is not installed." >&2
    exit 1
  fi
}

brand_panel() {
  local env_file="$PANEL_DIR/.env.example"
  local app_config="$PANEL_DIR/config/app.php"

  if [ -f "$env_file" ]; then
    echo "[info] Setting default APP_NAME to 'Haura Panel' in $env_file"
    sed -i "s/^APP_NAME=.*/APP_NAME=Haura Panel/" "$env_file"
  else
    echo "[warn] $env_file not found; skipping .env branding."
  fi

  if [ -f "$app_config" ]; then
    echo "[info] Setting Laravel fallback name to 'Haura Panel' in $app_config"
    sed -i "s/'name' => env('APP_NAME', 'Pterodactyl Panel')/'name' => env('APP_NAME', 'Haura Panel')/" "$app_config"
  else
    echo "[warn] $app_config not found; skipping config branding."
  fi
}

extract_archive() {
  local archive=$1
  local target_dir=$2
  mkdir -p "$target_dir"
  echo "[info] Extracting $archive into $target_dir/"
  tar -xzf "$archive" -C "$target_dir" --strip-components=1
}

clone_from_bundle() {
  local bundle=$1
  local target_dir=$2
  echo "[info] Cloning bundle $bundle into $target_dir/"
  git clone "$bundle" "$target_dir"
}

clone_from_git() {
  local repo=$1
  local target_dir=$2
  echo "[info] Cloning $repo into $target_dir/"
  git clone --depth=1 "$repo" "$target_dir"
}

import_component() {
  local component=$1
  local archive=$2
  local bundle=$3
  local repo=$4
  local target_dir=$5
  local allow_git=$6

  if [ -d "$target_dir/.git" ] || [ -d "$target_dir" ] && [ -n "$(ls -A "$target_dir" 2>/dev/null)" ]; then
    echo "[info] $component already present at $target_dir; skipping import."
    return
  fi

  if [ -n "$archive" ]; then
    extract_archive "$archive" "$target_dir"
    return
  fi

  if [ -n "$bundle" ]; then
    clone_from_bundle "$bundle" "$target_dir"
    return
  fi

  if [ "$allow_git" = "true" ]; then
    clone_from_git "$repo" "$target_dir"
    return
  fi

  echo "[error] No source provided for $component. Supply an archive, bundle, or enable --allow-git-clone." >&2
  exit 1
}

main() {
  local panel_archive=""
  local wings_archive=""
  local panel_bundle=""
  local wings_bundle=""
  local allow_git="false"

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --panel-archive)
        panel_archive="$2"; shift 2;;
      --wings-archive)
        wings_archive="$2"; shift 2;;
      --panel-bundle)
        panel_bundle="$2"; shift 2;;
      --wings-bundle)
        wings_bundle="$2"; shift 2;;
      --allow-git-clone)
        allow_git="true"; shift 1;;
      -h|--help)
        usage; exit 0;;
      *)
        echo "[error] Unknown option: $1" >&2
        usage; exit 1;;
    esac
  done

  require_cmd tar
  require_cmd git
  require_cmd sed

  import_component "panel" "$panel_archive" "$panel_bundle" "$PANEL_REPO" "$PANEL_DIR" "$allow_git"
  brand_panel
  import_component "wings" "$wings_archive" "$wings_bundle" "$WINGS_REPO" "$WINGS_DIR" "$allow_git"

  echo "[done] Panel and wings imported. Follow upstream install docs inside ./panel and ./wings with Haura branding."
}

main "$@"
