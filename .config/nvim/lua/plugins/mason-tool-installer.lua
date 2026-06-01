return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  dependencies = { 'williamboman/mason.nvim' },
  config = function()
    require('mason-tool-installer').setup {
      ensure_installed = {
        -- formatters
        'stylua',
        'prettier',
        'prettierd',
        'shfmt',
        'taplo',
        'ruff',
        'google-java-format',
        -- optional for C/C++
        'clang-format',

        -- linters
        'shellcheck',
        'markdownlint',
      },
      auto_update = false,
      run_on_start = true,
    }
  end,
}
