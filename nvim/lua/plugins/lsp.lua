return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {},
        bashls = {},
        jsonls = {},

        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
              validate = true,
              format = { enable = true },

              -- фикс конфликта схем
              schemaStore = {
                enable = false,
                url = "",
              },

              schemas = {
                ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.0-standalone-strict/all.json"] = {
                  "*.yaml",
                  "*.yml",
                },
                ["http://json.schemastore.org/docker-compose"] = "docker-compose*.yml",
              },
            },
          },
        },

        pyright = {},
        dockerls = {},
        terraformls = {},
        ansiblels = {},
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "bash-language-server",
        "json-lsp",
        "yaml-language-server",
        "pyright",
        "dockerfile-language-server",
        "terraform-ls",
        "ansible-language-server",
      },
    },
  },
}
