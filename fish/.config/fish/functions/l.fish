# Defined in - @ line 1
function l --wraps exa --description 'alias l exa -h --icons --group-directories-first'
	exa -h --icons --color-scale --group-directories-first $argv;
end
