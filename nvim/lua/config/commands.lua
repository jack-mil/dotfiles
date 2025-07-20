-- Define user commands to be used from command mode (or mapped to keymaps in other config)

vim.api.nvim_create_user_command('Terminal', function(opts)
  local action = opts.fargs[0] or 'toggle'
  if action == 'close' then
    require('config.terminal').close_term()
  else
    require('config.terminal').toggle_term()
  end
end, {
  nargs = '?',
  complete = function()
    return { 'toggle', 'close' }
  end,
  desc = 'Toggle or close the floating terminal',
})
