return {
  -- Python LSP + tooling
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {},  -- modern pyright fork, better than pyright
        ruff = {},          -- ruff as LSP for linting + formatting
      },
    },
  },

  -- Treesitter: syntax highlighting for Python
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "python",
        "toml",   -- pyproject.toml
      })
    end,
  },

  -- use ruff for formatting on save
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
      },
    },
  },

  -- use ruff for linting
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "ruff" },
      },
    },
  },
}

