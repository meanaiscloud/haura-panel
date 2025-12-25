
<?php

use Haura\Features\Feature;

return new Feature(
    "offline_and_airgapped",
    "Offline and Airgapped",
    "No-internet installs with artifact mirrors and deterministic updates.",
    ["offline", "supplychain"],
    ["backend", "wings"]
);
