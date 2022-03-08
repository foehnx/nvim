vim.g.gitblame_display_virtual_text = 0
vim.g.gitblame_date_format = '%r'
local git_blame = require('gitblame')

require('lualine').setup {
  options={theme = 'palenight'},
  sections = {
    -- lualine_a = {'mode'},
    lualine_a = {'branch', 'diff'},
    lualine_b = {'filename'},
    lualine_c = { { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available } },
    lualine_x = {'lsp_progress'},
    lualine_y = {'diagnostics', 'filetype'},
    lualine_z = {'progress', 'location'}
  },
}

