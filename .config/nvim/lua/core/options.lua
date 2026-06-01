-- Visible whitespace
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣', eol = '↲' }

-- Command preview + confirmations
vim.opt.inccommand = 'split'
vim.opt.confirm = true

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.showtabline = 1
vim.opt.pumheight = 10
vim.opt.cmdheight = 1
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8
vim.opt.whichwrap = 'bs<>[]hl'
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Mouse/clipboard
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'

-- Editing
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = '↪ ' -- optional

-- Indent defaults (let guess-indent override per buffer)
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.autoindent = true
-- vim.opt.softtabstop = 4 -- optional; usually not needed

-- Swap/backup/undo
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Timing
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Completion menu behavior (for nvim-cmp style)
vim.opt.completeopt = { 'menuone', 'noselect' }

-- Text/formatting tweaks
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.conceallevel = 0
vim.opt.fileencoding = 'utf-8'
vim.opt.iskeyword:append '-'
vim.opt.formatoptions:remove { 'c', 'r', 'o' }
-- vim.opt.shortmess:append('c') -- optional

-- Optional: keep Vim and Neovim plugins separate
-- vim.opt.runtimepath:remove('/usr/share/vim/vimfiles')
