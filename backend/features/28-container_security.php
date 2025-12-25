
<?php

use Haura\Features\Feature;

return new Feature(
    "container_security",
    "Container Security",
    "Image signing, SBOM attestation, and runtime policy enforcement.",
    ["security", "containers"],
    ["backend", "wings"]
);
