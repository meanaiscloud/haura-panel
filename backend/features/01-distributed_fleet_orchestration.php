
<?php

use Haura\Features\Feature;

return new Feature(
    "distributed_fleet_orchestration",
    "Distributed Fleet Orchestration",
    "Multi-cluster coordination with per-region scheduling and health-aware placement.",
    ["orchestration", "multi-region"],
    ["backend", "wings"]
);
