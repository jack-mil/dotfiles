return {
  "karb94/neoscroll.nvim",
  event = "WinScrolled",
  config = function ()
    require('neoscroll').setup({ easing = "cubic" })
  end
}