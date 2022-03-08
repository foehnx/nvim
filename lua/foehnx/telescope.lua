function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local telescope = require('telescope')

telescope.setup({
  map('n', '<space>ff', ':Telescope find_files<CR>'),
  map('n', '<space>fb', ':Telescope buffers<CR>'),
  map('n', '<space>fg', ':Telescope live_grep<CR>'),
})
telescope.load_extension('fzf')
