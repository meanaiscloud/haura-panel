
<?php

use Haura\Features\Feature;

return new Feature(
    "network_microsegmentation",
    "Network Microsegmentation",
    "Intent-based network policies with service identities and audit trails.",
    ["network", "security"],
    ["backend", "wings"]
);
