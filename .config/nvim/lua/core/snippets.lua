-- Custom code snippets for different purposes

-- Prevent LSP from overwriting treesitter color settings
-- https://github.com/NvChad/NvChad/issues/1907
vim.hl.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

-- Appearance of diagnostics
vim.diagnostic.config {
  virtual_text = {
    prefix = '●',
    -- Add a custom format function to show error codes
    format = function(diagnostic)
      local code = diagnostic.code and string.format('[%s]', diagnostic.code) or ''
      return string.format('%s %s', code, diagnostic.message)
    end,
  },
  underline = false,
  update_in_insert = true,
  float = {
    source = true, -- Or "if_many"
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
      [vim.diagnostic.severity.HINT] = '󰌵 ',
    },
  },
  -- Make diagnostic background transparent
  on_ready = function() vim.cmd 'highlight DiagnosticVirtualText guibg=NONE' end,
}

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Trim trailing whitespace + extra blank lines at EOF for specified files
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.vim', '.vimrc', 'vimrc' },
  callback = function()
    -- 1) Trim trailing spaces/tabs at end of lines
    vim.cmd [[%s/\s\+$//e]]

    -- 2) Trim extra blank lines at end of file
    -- Delete empty lines at EOF (but never delete the last remaining line)
    while vim.fn.line '$' > 1 and vim.fn.getline '$' == '' do
      vim.cmd '$delete'
    end
  end,
})

-- 在 markdown 和文本文件中自动打开拼写检查
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'text' },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { 'en_us', 'cjk' }
  end,
})
