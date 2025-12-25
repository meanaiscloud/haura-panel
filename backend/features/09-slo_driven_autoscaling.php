
<?php

use Haura\Features\Feature;

return new Feature(
    "slo_driven_autoscaling",
    "SLO-Driven Autoscaling",
    "Scales fleets using latency and error budgets instead of raw utilization.",
    ["autoscaling", "slo"],
    ["backend", "wings"]
);
