--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["n"] = "nzzzv"
lvim.keys.normal_mode["N"] = "Nzzzv"
lvim.keys.visual_mode["<leader>p"] = "\"_dP"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
-- lvim.colorscheme = "lunar"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
-- lvim.builtin.alpha.dashboard.section.header.val = {}
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.default = ""

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/configuration/language-features/language-servers>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "yamlls" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "emmet_ls"
end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = vim.api.nvim_create_autocmd("CursorHold", {
--   buffer = bufnr,
--   callback = function()
--     local opts = {
--       focusable = false,
--       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
--       border = 'rounded',
--       source = 'always',
--       prefix = ' ',
--       scope = 'cursor',
--     }
--     vim.diagnostic.open_float(nil, opts)
--   end
-- })
-- -- linters, formatters and code actions <https://www.lunarvim.org/docs/configuration/language-features/linting-and-formatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }
-- local code_actions = require "lvim.lsp.null-ls.code_actions"
-- code_actions.setup {
--   {
--     exe = "eslint",
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- Additional Plugins <https://www.lunarvim.org/docs/configuration/plugins/user-plugins>
lvim.plugins = {
  -- Games
  -- :Tetris
  {
    "alec-gibson/nvim-tetris"
  },
  -- :KillKillKill
  {
    "seandewar/killersheep.nvim"
  },
  -- :CellularAutomaton make_it_rain
  -- :CellularAutomaton game_of_life
  {
    "Eandrju/cellular-automaton.nvim"
  },
  -- :BlackJackNewGame
  -- :BlackJackResetScores
  {
    "alanfortlink/blackjack.nvim"
  },
  -- Misc
  {
    "towolf/vim-helm"
  },
  {
    "norcalli/nvim-colorizer.lua"
  },
  {
    "christoomey/vim-tmux-navigator"
  },
  {
    "frankroeder/parrot.nvim",
    dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim' },
    config = function()
      require("parrot").setup {
        providers = {
          ollama = {
            endpoint = "http://192.168.31.10:11434/api/chat",
            topic = {
              model = "qwen2.5-coder:14b",
              params = { max_tokens = 32 }
            }
          },
        },
      }
    end,
  },
  -- TODO uncomment when curl problem fixed
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("chatgpt").setup({
  --       api_host_cmd = 'echo http://192.168.31.10:11434',
  --       api_key_cmd = 'echo ""',
  --       openai_params = {
  --         model = "qwen2.5-coder:14b",
  --         frequency_penalty = 0,
  --         presence_penalty = 0,
  --         max_tokens = 4095,
  --         temperature = 0.2,
  --         top_p = 0.1,
  --         n = 1,
  --       },
  --       openai_edit_params = {
  --         model = "qwen2.5-coder:14b",
  --         frequency_penalty = 0,
  --         presence_penalty = 0,
  --         temperature = 0,
  --         top_p = 1,
  --         n = 1,
  --       }
  --     })
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "folke/trouble.nvim", -- optional
  --     "nvim-telescope/telescope.nvim"
  --   }
  -- },
  "aca/emmet-ls",
  config = function()
    local lspconfig = require("lspconfig")
    local configs = require("lspconfig/configs")

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    }

    if not lspconfig.emmet_ls then
      configs.emmet_ls = {
        default_config = {
          cmd = { "emmet-ls", "--stdio" },
          filetypes = {
            "html",
            "css",
            "javascript",
            "typescript",
            "eruby",
            "typescriptreact",
            "javascriptreact",
            "svelte",
            "vue",
          },
          root_dir = function(fname)
            return vim.loop.cwd()
          end,
          settings = {},
        },
      }
    end
    lspconfig.emmet_ls.setup({ capabilities = capabilities })
  end,
}

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

-- Setup theme

lvim.transparent_window = true
lvim.colorscheme = "tokyonight-moon"

-- Configure yamlls for specific .yaml files

local yamllscfg = {
  settings = {
    yaml = {
      hover = true,
      completion = true,
      validate = true,
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      schemas = {
        ['http://json.schemastore.org/golangci-lint.json']      = '.golangci.{yml,yaml}',
        ['http://json.schemastore.org/github-workflow.json']    = '.github/workflows/*.{yml,yaml}',
        ['http://json.schemastore.org/github-action.json']      = '.github/action.{yml,yaml}',
        ['http://json.schemastore.org/ansible-stable-2.9.json'] = 'roles/tasks/*.{yml,yaml}',
        ['http://json.schemastore.org/ansible-playbook.json']   = 'playbook.{yml,yaml}',
        ['http://json.schemastore.org/prettierrc.json']         = '.prettierrc.{yml,yaml}',
        ['http://json.schemastore.org/stylelintrc.json']        = '.stylelintrc.{yml,yaml}',
        ['http://json.schemastore.org/circleciconfig.json']     = '.circleci/**/*.{yml,yaml}',
        ['http://json.schemastore.org/kustomization.json']      = 'kustomization.{yml,yaml}',
        ['http://json.schemastore.org/helmfile.json']           = 'templates/**/*.{yml,yaml}',
        ['http://json.schemastore.org/chart.json']              = 'Chart.{yml,yaml}',
        ['http://json.schemastore.org/gitlab-ci.json']          = '/*lab-ci.{yml,yaml}',
        ['http://json.schemastore.org/tsconfig.json']           = 'tsconfig.{yml,yaml}',
      }
    },
  }
}

require("lvim.lsp.manager").setup("yaml_language_server", yamllscfg)

-- Setup colorizer for color highlighting

require 'colorizer'.setup()

-- Setup expanding error messages on hover

vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
