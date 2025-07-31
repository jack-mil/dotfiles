Custom selection and order of git-graph colors
```json
    "git-graph.graph.colours": [
        "#e5c890",
        "#8caaee",
        "#ef9f76",
        "#ca9ee6",
        "#ea999c",
        "#a6d189",
        "#f4b8e4",
        "#81c8be",
        "#ea999c",
        "#eebebe",
        "#99d1db",
        "#e78284",
        "#f2d5cf"
    ]
```

```json
"editorGutter.addedSecondaryBackground":"#a6d189",
"editorGutter.modifiedSecondaryBackground": "#e5c890",
"editorGutter.deletedSecondaryBackground": "#e78284"
```

indent rainbow ctp Frappe with 50% base mix
```json
    "indentRainbow.colors": [
        "#8B7E6B",
        "#5E6F9A",
        "#906A5E",
        "#8D6771",
        "#7D6996",
        "#6B8368",
        "#927695",
        "#597E82",
        "#8F7982",
        "#91858B",
        "#658391",
        "#8C5B65",
    ],
```

Generated with whiskers template
```handlebars
---
whiskers:
  version: 2.5.1
  matrix:
    - flavor
  filename: "settings.json"
  hex_format: "#{{R}}{{G}}{{B}}"
---
{%- macro d(c) -%}
{{ c | mix(color=base, amount=0.50) | get(key="hex") }}
{%- endmacro d -%}
"indentRainbow.colors": [
    "{{ self::d(c=yellow) }}",
    "{{ self::d(c=blue) }}",
    "{{ self::d(c=peach) }}",
    "{{ self::d(c=maroon) }}",
    "{{ self::d(c=mauve) }}",
    "{{ self::d(c=green) }}",
    "{{ self::d(c=pink) }}",
    "{{ self::d(c=teal) }}",
    "{{ self::d(c=flamingo) }}",
    "{{ self::d(c=rosewater) }}",
    "{{ self::d(c=sky) }}",
    "{{ self::d(c=red) }}",
],
```
