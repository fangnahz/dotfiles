return {
  'folke/tokyonight.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('tokyonight').setup {
      styles = {
        comments = { italic = false }, -- Disable italics in comments
      },
    }

    local bg_transparent = true

    local function apply_theme()
      if bg_transparent then
        require('tokyonight').setup {
          transparent = true,
          styles = {
            comments = { italic = false },
            sidebars = 'transparent',
            floats = 'transparent',
          },
        }
      else
        require('tokyonight').setup {
          styles = { comments = { italic = false } },
        }
      end

      vim.cmd.colorscheme 'tokyonight-night'
    end

    local function toggle_transparency()
      bg_transparent = not bg_transparent
      apply_theme()
    end

    -- initial apply
    apply_theme()

    vim.keymap.set('n', '<leader>bg', toggle_transparency, { noremap = true, silent = true, desc = 'Toggle Background toggle_transparency' })
  end,
}
