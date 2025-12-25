<?php

namespace Haura\Features;

class Feature
{
    private string $id;
    private string $name;
    private string $summary;
    /** @var string[] */
    private array $tags;
    /** @var string[] */
    private array $components;

    /**
     * @param string[] $tags
     * @param string[] $components
     */
    public function __construct(string $id, string $name, string $summary, array $tags = [], array $components = [])
    {
        $this->id = $id;
        $this->name = $name;
        $this->summary = $summary;
        $this->tags = $tags;
        $this->components = $components;
    }

    /**
     * @return array<string, mixed>
     */
    public function toArray(): array
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'summary' => $this->summary,
            'tags' => $this->tags,
            'components' => $this->components,
        ];
    }

    public function toJson(): string
    {
        return (string) json_encode($this->toArray(), JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES);
    }
}
