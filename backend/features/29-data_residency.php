
<?php

use Haura\Features\Feature;

return new Feature(
    "data_residency",
    "Data Residency",
    "Region-bound storage and key scopes with residency-aware scheduling.",
    ["compliance", "data"],
    ["backend", "wings"]
);
