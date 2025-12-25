#!/usr/bin/env php
<?php

require_once __DIR__.'/../Feature.php';
require_once __DIR__.'/../FeatureLoader.php';

use Haura\Features\FeatureLoader;

$featuresDir = realpath(__DIR__.'/../features');
$catalog = FeatureLoader::load($featuresDir ?: '');

echo json_encode(array_map(fn($feature) => $feature->toArray(), $catalog), JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES)."\n";
