return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'gruvbox'
      },
      sections = {
        lualine_a = {
          {
            'diff',
            colored = true,
            added    = 'DiffAdd',    -- Changes the diff's added color
            modified = 'DiffChange', -- Changes the diff's modified color
            removed  = 'DiffDelete', -- Changes the diff's removed color you
            symbols = {added = '+', modified = '~', removed = '-'}, -- Changes the symbols used by the diff.
            source = nil, -- A function that works as a data source for diff.
          }
        },
        lualine_c = {}
      },
      inactive_sections = {
        lualine_c = {},
        lualine_x = {}
      },
      tabline = {
        lualine_a = {'buffers'},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      }
    }
  end
}
