require('lualine').setup {
  options = {
 --   icons_enabled = true,
    theme = 'gruvbox'
  },
  sections = {
    lualine_a = {
      {
        'diff',
        colored = true, -- Displays a colored diff status if set to true
        -- diff_color = {
        --   -- Same color values as the general color option can be used here.
          added    = 'DiffAdd',    -- Changes the diff's added color
          modified = 'DiffChange', -- Changes the diff's modified color
          removed  = 'DiffDelete', -- Changes the diff's removed color you
        -- },
        symbols = {added = '+', modified = '~', removed = '-'}, -- Changes the symbols used by the diff.
        source = nil, -- A function that works as a data source for diff.
        -- It must return a table as such:
        --   { added = add_count, modified = modified_count, removed = removed_count }
        -- or nil on failure. count <= 0 won't be displayed.
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
