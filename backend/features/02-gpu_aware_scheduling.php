
<?php

use Haura\Features\Feature;

return new Feature(
    "gpu_aware_scheduling",
    "GPU-Aware Scheduling",
    "Places workloads on GPU nodes with vendor/VRAM constraints and quota enforcement.",
    ["gpu", "scheduling"],
    ["backend", "wings"]
);
