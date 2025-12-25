
<?php

use Haura\Features\Feature;

return new Feature(
    "secret_management",
    "Secret Management",
    "Envelope encryption, auto-rotations, and per-scope secrets injection.",
    ["security", "secrets"],
    ["backend", "wings"]
);
