
<?php

use Haura\Features\Feature;

return new Feature(
    "tenant_isolation",
    "Tenant Isolation",
    "Hard multi-tenant boundaries with policy-scoped API tokens and resource caps.",
    ["multitenancy", "security"],
    ["backend", "wings"]
);
