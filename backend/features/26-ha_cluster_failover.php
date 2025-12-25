
<?php

use Haura\Features\Feature;

return new Feature(
    "ha_cluster_failover",
    "HA Cluster Failover",
    "Control-plane HA with quorum health, fencing, and failover drills.",
    ["ha", "resilience"],
    ["backend", "wings"]
);
