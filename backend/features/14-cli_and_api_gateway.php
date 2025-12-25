
<?php

use Haura\Features\Feature;

return new Feature(
    "cli_and_api_gateway",
    "CLI and API Gateway",
    "Typed CLI plus gateway with rate plans, JWT/OIDC auth, and per-tenant limits.",
    ["api", "cli"],
    ["backend", "frontend"]
);
