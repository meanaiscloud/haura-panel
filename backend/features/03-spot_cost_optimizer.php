
<?php

use Haura\Features\Feature;

return new Feature(
    "spot_cost_optimizer",
    "Spot Cost Optimizer",
    "Uses spot/preemptible nodes with fallback to on-demand capacity and policy controls.",
    ["cost", "autoscaling"],
    ["backend", "wings"]
);
