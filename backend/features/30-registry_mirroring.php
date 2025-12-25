
<?php

use Haura\Features\Feature;

return new Feature(
    "registry_mirroring",
    "Registry Mirroring",
    "Pull-through caching, airgap sync, and provenance enforcement for images.",
    ["registry", "supplychain"],
    ["backend", "wings"]
);
