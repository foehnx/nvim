function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

require('mini.comment').setup()
require('mini.cursorword').setup()
require('mini.indentscope').setup({
  draw = {
    delay = 10,
  },
  symbol = '|'
})
require('mini.pairs').setup()
require('mini.sessions').setup({
  autoread = true,
  autowrite = false,
  map('n', '<space>ss', '<cmd> lua MiniSessions.write()<CR>'),
})
require('mini.starter').setup()
-- require('mini.statusline').setup()
-- require('mini.tabline').setup()
require('mini.surround').setup()
-- require('mini.trailspace').setup()

