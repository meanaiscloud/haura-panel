
<?php

use Haura\Features\Feature;

return new Feature(
    "waf_dos_protection",
    "WAF and DoS Protection",
    "Managed WAF rulesets, adaptive rate limiting, and per-tenant traffic policies.",
    ["security", "network"],
    ["backend"]
);
