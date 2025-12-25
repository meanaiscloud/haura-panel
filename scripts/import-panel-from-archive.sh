#!/usr/bin/env bash
set -euo pipefail

# Usage: ./scripts/import-panel-from-archive.sh /path/to/pterodactyl-panel.tar.gz
# Extracts the official Pterodactyl panel source from a tar.gz archive into ./panel
# and applies minimal Haura branding defaults.

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 /path/to/pterodactyl-panel.tar.gz" >&2
  exit 1
fi

ARCHIVE_PATH="$1"
DEST_DIR="panel"

if [[ ! -f "$ARCHIVE_PATH" ]]; then
  echo "Archive not found: $ARCHIVE_PATH" >&2
  exit 1
fi

if [[ -d "$DEST_DIR" ]]; then
  echo "Destination $DEST_DIR already exists; refusing to overwrite." >&2
  exit 1
fi

mkdir -p "$DEST_DIR"

tar -xzf "$ARCHIVE_PATH" -C "$DEST_DIR" --strip-components=1

# Basic rebrand: set default Laravel app name and .env example.
if [[ -f "$DEST_DIR/.env.example" ]]; then
  sed -i 's/^APP_NAME=.*/APP_NAME="Haura Panel"/' "$DEST_DIR/.env.example"
fi

if [[ -f "$DEST_DIR/config/app.php" ]]; then
  sed -i "s/'name' => env('APP_NAME', 'Pterodactyl'),'/'name' => env('APP_NAME', 'Haura Panel'),/" "$DEST_DIR/config/app.php"
fi

echo "Panel source extracted to $DEST_DIR with Haura defaults applied."
