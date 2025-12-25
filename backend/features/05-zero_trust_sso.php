
<?php

use Haura\Features\Feature;

return new Feature(
    "zero_trust_sso",
    "Zero-Trust SSO",
    "Enforces device posture, WebAuthn, and per-tenant IdP SSO flows.",
    ["security", "identity"],
    ["backend", "frontend"]
);
