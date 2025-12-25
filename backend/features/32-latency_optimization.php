
<?php

use Haura\Features\Feature;

return new Feature(
    "latency_optimization",
    "Latency Optimization",
    "Latency-aware routing, anycast/CDN hints, and client RTT scoring.",
    ["network", "performance"],
    ["backend", "frontend"]
);
