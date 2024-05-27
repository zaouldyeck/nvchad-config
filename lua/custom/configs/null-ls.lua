local null_ls = require("null-ls")
--local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local opts = {
  sources = {
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.goimports_reviser,
    null_ls.builtins.formatting.golines,
  },
  on_attach = function(client, bufnr)
        -- Enable formatting on sync
        if client.supports_method("textDocument/formatting") then
          local format_on_save = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = format_on_save,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                bufnr = bufnr,
                filter = function(_client)
                  return _client.name == "null-ls"
                end
              })
            end,
          })
        end
      end
}
return opts
