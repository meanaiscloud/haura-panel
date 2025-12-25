
<?php

use Haura\Features\Feature;

return new Feature(
    "progressive_deploy_strategies",
    "Progressive Deploy Strategies",
    "Supports blue/green, canary, and traffic-shifted rollouts with automatic aborts on regressions.",
    ["deploy", "release"],
    ["backend", "frontend"]
);
