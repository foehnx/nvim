function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- System Clipboard
map('n', '<c-c>', '"+y')
map('n', '<c-v>', '"+p')
-- map('i', '<c-c>', '"+y')
-- map('i', '<c-v>', '"+p')


-- Save Session

