return {
  lazy = false,
  priority = 1000,
  "lervag/vimtex",
  ft = { "tex", "latex" },
  config = function()
    vim.g.vimtex_view_method = "zathura" -- or your preferred PDF viewer
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_quickfix_mode = 0
    vim.g.tex_flavor = "latex"

    vim.g.vimtex_compiler_latexmk = {
      build_dir = "",
      callback = 1,
      continuous = 1,
      executable = "latexmk",
      options = {
        "-verbose",
        "-file-line-error",
        "-synctex=1", -- Enable SyncTeX for inverse search
        "-interaction=nonstopmode",
      },
    }
    vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"

    vim.g.vimtex_syntax_conceal = {
      accents = 1,
      ligatures = 1,
      cites = 1,
      fancy = 1,
      spacing = 1,
      greek = 1,
      math_bounds = 1,
      math_delimiters = 1,
      math_fracs = 1,
      math_super_sub = 1,
      math_symbols = 1,
      sections = 1,
      styles = 1,
    }
    vim.opt.conceallevel = 2
  end,
}
