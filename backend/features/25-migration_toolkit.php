
<?php

use Haura\Features\Feature;

return new Feature(
    "migration_toolkit",
    "Migration Toolkit",
    "Import/export flows, validation, and downtime-minimized cutovers.",
    ["migration"],
    ["backend", "frontend"]
);
