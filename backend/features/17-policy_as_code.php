
<?php

use Haura\Features\Feature;

return new Feature(
    "policy_as_code",
    "Policy as Code",
    "OPA/Rego-style guardrails with staged/enforced modes and change approvals.",
    ["policy", "security"],
    ["backend"]
);
