-- Lazy Bootsrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)


--- Config --------------------------------------------------------------------
vim.opt.swapfile = false

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true


vim.o.guifont = "MesloLGS Nerd Font Mono:h10"
vim.g.neovide_floating_blur_amount_x = 10.0
vim.g.neovide_floating_blur_amount_y = 10.0
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_cursor_animate_command_line = false

vim.g.neovide_scale_factor = 0.9
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

if vim.g.neovide then
  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<D-c>', '"+y')    -- Copy
  vim.keymap.set('n', '<D-v>', '"+P')    -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P')    -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<C-R>+') -- Paste insert mode
end



--- Plugins -------------------------------------------------------------------
require("lazy").setup({
  -- UI ---------------------
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
  { 'echasnovski/mini.icons', version = false },
  {
    "folke/which-key.nvim",
		lazy = false,
		priority = 999,
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 10
    end,
  },
  {
    "folke/noice.nvim",
		lazy = false,
		priority = 998,
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    opts = {
      options = {
        mode = "tabs",
      },
    },
  },
  { "ojroques/nvim-bufdel", lazy=false, },
  { "numToStr/Comment.nvim", lazy=false, },
  { "github/copilot.vim" },
  { "nvim-pack/nvim-spectre", config=true, },
  {
    "nvim-zh/colorful-winsep.nvim",
    opts={
      no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "neo-tree" },
    },
    config = true,
    event = { "WinLeave" },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'arkav/lualine-lsp-progress',
    },
    opts = {
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {{'filename', path=1}},
        lualine_x = {'filetype'},
        lualine_y = {'diagnostics', 'lsp_progress'},
        lualine_z = { 'progress', 'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {},
        lualine_z = {}
      },
    }
  },
  -- Neotree ----------------
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("NeoTreeInit", { clear = true }),
        callback = function()
          local f = vim.fn.expand("%:p")
          if vim.fn.isdirectory(f) ~= 0 then
            vim.cmd("Neotree current dir=" .. f)
            vim.api.nvim_clear_autocmds({ group = "NeoTreeInit" })
          end
        end,
      })
    end,
    opts = {
      close_if_last_window = true,
      enable_git_status = true,
      filesystem = {
        hijack_netrw_behavior = "open_current",
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
      },
    },
  },
  -- Telescope --------------
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
        file_ignore_patterns = {
          "bazel-out/",
          "build/bazel-*",
          "build/build",
          "build/clones",
          "build/deploy",
          "build/deployed_params",
          "build/images",
          "build/install",
          "build/js",
          "build/host_aircam",
          "build/host_third_party",
          "graveyard",
          "third_party/boost",
          "third_party",
          "third_party_modules",
          "**/.git",
          "**/.svn",
          "**/.hg",
          "**/CVS",
          "**/.DS_Store",
          ".qtcreator*",
          "**/.mypy_cache",
          "**/*.chunk.css",
          "**/*.css.map",
          "**/*.chunk.js",
          "tags",
          "vehicle/qualcomm",
          "vehicle/nvidia",
          "external",
          "accessories/qualcomm",
          ".cache/clangd",
          "**/typescript_lcm",
          "**/typescript_lcm_channel",
          "**/pbtypes_js",
          "tools/lcmtype_auto_translation",
          "cloud/clients/customer_portal",
          "**/*.ts",
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.find_files, {})
      vim.keymap.set("n", "<C-b>", builtin.buffers, {})
      telescope.load_extension("ui-select")
      telescope.load_extension("live_grep_args")
      telescope.load_extension("fzf")
    end,
  },
  -- Git --------------------
	{
		"lewis6991/gitsigns.nvim",
    dependencies = { "tpope/vim-fugitive" },
    opts = {
      current_line_blame = true,
    },
	},
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config=true,
  },
  -- LSP --------------------
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
			ensure_installed = {
				"clangd",
				"rust_analyzer",
				"lua_ls",
				"pylsp",
				"ruff",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.pylsp.setup({
				capabilities = capabilities,
        settings = {
          pylsp = {
            plugins = {
              autopep8 = { enabled = false },
              flake8 = { enabled = false },
              pycodestyle = { enabled = false },
              pydocstyle = { enabled = false },
              pyflakes = { enabled = false },
              pylint = { enabled = false },
              mccabe = { enabled = false },
              yapf = { enabled = false },
            }
          }
        }
			})
			lspconfig.ruff_lsp.setup({
				capabilities = capabilities,
        init_options = {
            settings = {
                args = {
                  "--config=~/aircam/ruff.toml",
                },
            },
        },
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
    dependencies = {
		  "hrsh7th/cmp-nvim-lsp",
		  "L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
    },
		config = function()
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cpp = { "clang-format" },
        python = { "isort", "ruff_format" },
        lua = { "stylua" },
      },
      format_on_save = {
        timout_ms = 1000,
        lsp_format = "fallback",
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    config= function()
      require("lint").linters_by_ft = { python = { "mypy" } }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end
  },
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    opts = {
      outline_window = {
        auto_close = true,
        auto_jump = true,
      },
    },
},
},{
  pkg = {sources="lazy"}
})


--- Keymap --------------------------------------------------------------------
vim.g.mapleader = " "
vim.keymap.set("n", "<c-j>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<c-k>", ":bprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<c-h>", ":wincmd w<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<c-l>", ":wincmd W<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<c-h>", ":wincmd w<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<c-l>", ":wincmd W<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<c-t>", ":tabnew<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Tab>", ":tabnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", ":tabprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-q>", ":bd<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "<C-I>", vim.lsp.buf.format)

vim.keymap.set("n", "c-=", function() change_scale_factor(1.2) end, { noremap = true, silent = true })
vim.keymap.set("n", "c--", function() change_scale_factor(1/1.2) end, { noremap = true, silent = true })

vim.keymap.set("n", "c-Left", ":resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "c-Right", ":resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "c-Up", ":vertical resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "c-Down", ":vertical resize -2<CR>", { noremap = true, silent = true })

require("which-key").add({
  { "<leader>b", group = "Buffer" },
  { "<leader>ba", "<cmd>BufDelOthers<CR>", desc = "Close All Others" },
  { "<leader>bb", "<cmd>BufDel<CR>", desc = "Bye" },
  { "<leader>bj", "<cmd>bnext<CR>", desc = "Next" },
  { "<leader>bk", "<cmd>bprevious<CR>", desc = "Previous" },
  { "<leader>c", group = "Code" },
  { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
  { "<leader>cf", function()
			require("conform").format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, desc = "Format" },
  { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<CR>", desc = "Header/Source" },
  { "<leader>e", group = "Neotree" },
  { "<leader>eb", "<cmd>Neotree buffers reveal float<cr>", desc = "Buffers" },
  { "<leader>ee", "<cmd>Neotree filesystem reveal left<cr>", desc = "Explorer" },
  { "<leader>et", "<cmd>Neotree filesystem reveal toggle left<cr>", desc = "Explorer" },
  { "<leader>f", group = "Find" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
  { "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Diagnostics" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files" },
  { "<leader>fg", require('telescope').extensions.live_grep_args.live_grep_args, desc = "Grep" },
  { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
  { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "History" },
  { "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
  { "<leader>l", "<cmd>LazyGit<CR>", desc = "LazyGit" },
  { "<leader>p", group = "Packages" },
  { "<leader>pl", "<cmd>Lazy<cr>", desc = "Lazy" },
  { "<leader>pm", "<cmd>Mason<cr>", desc = "Mason" },
  { "<leader>s", group = "Replace" },
  { "<leader>sp", function() require("spectre").open_file_search({select_word=true}) end, desc = "Search File" },
  { "<leader>ss", require("spectre").toggle, desc = "Toggle Spectre" },
  { "<leader>sw", function() require("spectre").open_visual({select_word=true}) end, desc = "Search Word" },
  { "<leader>w", "<cmd>write<CR>", desc = "Write" },
  { "<leader>o", "<cmd>Outline<CR>", desc = "Outline" },
})
