
<?php

use Haura\Features\Feature;

return new Feature(
    "event_bus_webhooks",
    "Event Bus and Webhooks",
    "Reliable event delivery with replay, signatures, and webhook templating.",
    ["integrations", "events"],
    ["backend"]
);
