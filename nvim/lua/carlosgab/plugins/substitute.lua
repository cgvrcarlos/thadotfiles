return {
  "gbprod/substitute.nvim",
  event = {"BufReadPre", "BufNewFile"},
  config = function()
    local substitute = require("substitute")

    substitute.setup()

    vim.keymap.set("n", "s", substitute.operator, { desc = "Substitute with motion" })
    vim.keymap.set("n", "ss", substitute.line, { desc = "Substitute line" })
    vim.keymap.set("n", "S", substitute.line, { desc = "Substitute to end of line" })
    vim.keymap.set("x", "s", require('substitute').visual, { desc = "Substitute in visual mode" })
  end,
}
