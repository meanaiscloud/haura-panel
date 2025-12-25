
<?php

use Haura\Features\Feature;

return new Feature(
    "billing_and_metering",
    "Billing and Metering",
    "Usage metering, prepaid/postpaid billing, and invoice exports.",
    ["billing", "metering"],
    ["backend"]
);
