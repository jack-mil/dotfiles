{{#if (eq dotter.os "windows")}}
echo "Deployed on Windows: {{doter.packages}}"
{{else}}
echo "Deployed on Linux: {{#each dotter.packages}}{{#if this}}{{@key}} {{/if}}{{/each}}"
{{/if}}