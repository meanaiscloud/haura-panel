
<?php

use Haura\Features\Feature;

return new Feature(
    "data_pipelines_storage",
    "Data Pipelines and Storage",
    "Managed buckets, object lifecycle, and ETL triggers from events.",
    ["data", "storage"],
    ["backend"]
);
