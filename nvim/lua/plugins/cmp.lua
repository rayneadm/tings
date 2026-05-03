return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = vim.list_extend(opts.sources or {}, {
        { name = "path" },
        { name = "buffer" },
      })
    end,
  },
}
