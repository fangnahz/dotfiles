require 'core.options' -- Load general options
require 'core.keymaps' -- Load general keymaps
require 'core.snippets' -- Custom code snippets

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- Import color theme based on environment variable NVIM_THEME
-- 注意，默认值要和 lua/plugins/lualine.lua 保持一致
local default_color_scheme = 'tokyonight'
local env_var_nvim_theme = os.getenv 'NVIM_THEME' or default_color_scheme

-- Define a table of theme modules
local themes = {
  tokyonight = 'plugins.themes.tokyonight',
  nord = 'plugins.themes.nord',
  onedark = 'plugins.themes.onedark',
}

require('lazy').setup({
  require(themes[env_var_nvim_theme]),
  require 'plugins.telescope',
  require 'plugins.treesitter',
  require 'plugins.lsp',
  -- require 'plugins.lsp-tt',
  require 'plugins.autocompletion',
  -- require 'plugins.autocompletion-tt',
  require 'plugins.autoformat',
  -- require 'plugins.autoformat-tt',
  require 'plugins.lualine',
  require 'plugins.bufferline',
  require 'plugins.neo-tree',
  require 'plugins.oil',
  require 'plugins.alpha',
  require 'plugins.indent-blankline',
  require 'plugins.lazygit',
  require 'plugins.comment',
  require 'plugins.debug',
  require 'plugins.gitsigns',
  require 'plugins.database',
  require 'plugins.misc',
  require 'plugins.harpoon',
  -- require 'plugins.avante',
  require 'plugins.aerial',
  require 'plugins.vim-tmux-navigator',
  require 'plugins.which-key',
  require 'plugins.mini',
  require 'plugins.lint',
  require 'plugins.mason-tool-installer',
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
