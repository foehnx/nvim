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
  -- autoread = true,
  autowrite = false,
  map('n', '<space>ss', '<cmd> lua MiniSessions.write()<CR>'),
})

local starter = require('mini.starter')
starter.setup({
  items = {
    starter.sections.sessions(5, true),
    starter.sections.recent_files(8, false),
    starter.sections.recent_files(8, true),
    starter.sections.telescope(),
    starter.sections.builtin_actions(),
  },
  content_hooks = {
    starter.gen_hook.adding_bullet(),
    starter.gen_hook.indexing('all', { 'Builtin actions' }),
    starter.gen_hook.padding(3, 2),
    starter.gen_hook.aligning('center', 'center'),
  },
})
require('mini.surround').setup()
-- require('mini.trailspace').setup()

