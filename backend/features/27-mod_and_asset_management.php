
<?php

use Haura\Features\Feature;

return new Feature(
    "mod_and_asset_management",
    "Mod and Asset Management",
    "Curated mod catalogs with integrity checks and lifecycle policies.",
    ["mods", "assets"],
    ["backend", "frontend", "wings"]
);
