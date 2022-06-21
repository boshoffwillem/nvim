local status_ok, snips = pcall(require, "luasnip")
if not status_ok then
  return
end

local types = require "luasnip.util.types"

snips.config.set_config {
    history = true,
    updateevents = "TextChanged, TextChangedI",
    enable_autosnippets = true,
}

-- this will exapand the current item or jump
-- to the next item within the snippet
vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if snips.expand_or_jumpable() then
        snips.expand_or_jump()
    end
end, { silent = true })
-- move to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if snips.jumpable(-1) then
        snips.jump(-1)
    end
end, { silent = true })

-- This is useful for selecting choice nodes
vim.keymap.set("i", "<c-l>", function()
    if snips.choice_active() then
        snips.change_choice(1)
    end
end)

-- reload snippets
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/AppData/Local/nvim/after/plugin/luasnip.lua<CR>")

snips.add_snippets("all", {
    snips.snippet("///", {
        snips.text_node("/// <summary>"),
        snips.text_node("/// <summary>"),
    })
})
