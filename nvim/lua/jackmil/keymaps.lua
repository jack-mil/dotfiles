function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

-- use jj to exit insert mode (not present in english
imap('jj','<Esc>')

-- mapping to insert newline above/below in normal mode
nmap('<C-J>', 'mao<Esc>`a')
nmap('<C-K>', 'maO<Esc>`a')



