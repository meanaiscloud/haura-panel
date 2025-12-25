
<?php

use Haura\Features\Feature;

return new Feature(
    "ephemeral_dev_envs",
    "Ephemeral Dev Environments",
    "One-click preview environments with TTL cleanup and branch-based routing.",
    ["developer", "preview"],
    ["backend", "frontend", "wings"]
);
