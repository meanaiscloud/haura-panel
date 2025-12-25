<?php

namespace Haura\Features;

class FeatureLoader
{
    /**
     * @return Feature[]
     */
    public static function load(string $featuresDir): array
    {
        $catalog = [];
        foreach (glob(rtrim($featuresDir, '/').'/*.php') as $file) {
            $feature = include $file;
            if ($feature instanceof Feature) {
                $catalog[] = $feature;
            }
        }

        return $catalog;
    }
}
