return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        yaml = { "prettierd" },
        json = { "prettierd" },
        python = { "black" },
        sh = { "shfmt" },
      },
    },
  },
}
