return {
  -- file explorer sidebar (already in LazyVim, just configure it)
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "left",
        width = 30,
      },
      filesystem = {
        follow_current_file = { enabled = true },
        hide_dotfiles = false,
      },
    },
  },
}

