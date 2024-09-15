{{#if (eq dotter.os "windows")}}
echo "Deployed on Windows: {{{#each dotter.packages}}{{#if this}}{{@key}} {{/if}}{{/each}}"
{{else}}
echo "Deployed on Linux: {{#each dotter.packages}}{{#if this}}{{@key}} {{/if}}{{/each}}"
{{/if}}
