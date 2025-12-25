
<?php

use Haura\Features\Feature;

return new Feature(
    "backup_and_dr",
    "Backup and DR",
    "Continuous backups with point-in-time restore and regional DR failover plans.",
    ["backup", "recovery"],
    ["backend"]
);
