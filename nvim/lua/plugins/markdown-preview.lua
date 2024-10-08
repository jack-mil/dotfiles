-- Render markdown in the editor
-- disabled because requires node.js (uggh)
return {
  'iamcco/markdown-preview.nvim',
  enabled = false,
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  build = function()
    vim.fn['mkdp#util#install']()
  end,
}
