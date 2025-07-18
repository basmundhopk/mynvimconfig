return {
  "SirVer/ultisnips",
  lazy = false,  -- Load immediately on startup (highest priority)
  priority = 1000,
  config = function()
    vim.g.UltiSnipsExpandTrigger = "<tab>"
    vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
    vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
    vim.g.UltiSnipsEditSplit = "vertical"
    vim.g.UltiSnipsSnippetDirectories = { "UltiSnips" }
  end,
}
