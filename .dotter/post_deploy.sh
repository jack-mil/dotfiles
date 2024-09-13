{{#if (and dotter.packages.git signing_key)}}
    {{#if (eq dotter.os "windows")}}
@echo off
for /f "tokens=*" %%j in ('type {{replace (replace signing_key "~" "%USERPROFILE%") "/" "\\"}}') do set SSH_KEY=%%j
echo {{email}} namespaces="git" %SSH_KEY% >> %USERPROFILE%\.ssh\allowed_signers
    {{else}}
echo "{{email}} namespaces=\"git\" $(cat {{signing_key}})" >> ~/.ssh/allowed_signers
    {{/if}}
{{/if}}