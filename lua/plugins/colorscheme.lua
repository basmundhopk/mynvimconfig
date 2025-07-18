return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
      light = "latte",
      dark = "mocha",
    },
    transparent_background = true,
    show_end_of_buffer = false,
    term_colors = false,
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    no_italic = false,
    no_bold = false,
    no_underline = false,
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    color_overrides = {},
    custom_highlights = function(colors)
      return {
        Comment = { fg = colors.overlay1 },
        LineNr = { fg = colors.overlay0 },
        CursorLineNr = { fg = colors.lavender },
        -- Custom highlights for better readability
        ["@variable"] = { fg = colors.text },
        ["@variable.builtin"] = { fg = colors.red, style = { "italic" } },
        ["@parameter"] = { fg = colors.maroon, style = { "italic" } },
        ["@string"] = { fg = colors.green },
        ["@keyword"] = { fg = colors.mauve, style = { "italic" } },
        ["@keyword.function"] = { fg = colors.mauve },
        ["@keyword.return"] = { fg = colors.red },
        ["@function"] = { fg = colors.blue },
        ["@function.builtin"] = { fg = colors.peach },
        ["@type"] = { fg = colors.yellow },
        ["@type.builtin"] = { fg = colors.yellow, style = { "italic" } },
        -- Enhanced floating windows
        NormalFloat = { bg = colors.mantle },
        FloatBorder = { fg = colors.blue },
        FloatTitle = { fg = colors.text, style = { "bold" } },
        -- Better popup menu
        Pmenu = { bg = colors.surface0, fg = colors.text },
        PmenuSel = { bg = colors.surface1, fg = colors.text },
        PmenuSbar = { bg = colors.surface1 },
        PmenuThumb = { bg = colors.overlay0 },
        -- Enhanced search
        Search = { bg = colors.yellow, fg = colors.base },
        IncSearch = { bg = colors.red, fg = colors.base },
        CurSearch = { bg = colors.red, fg = colors.base },
        -- Better visual selection
        Visual = { bg = colors.surface1 },
        -- Enhanced diagnostics
        DiagnosticError = { fg = colors.red },
        DiagnosticWarn = { fg = colors.yellow },
        DiagnosticInfo = { fg = colors.sky },
        DiagnosticHint = { fg = colors.teal },
        DiagnosticVirtualTextError = { fg = colors.red, bg = colors.none },
        DiagnosticVirtualTextWarn = { fg = colors.yellow, bg = colors.none },
        DiagnosticVirtualTextInfo = { fg = colors.sky, bg = colors.none },
        DiagnosticVirtualTextHint = { fg = colors.teal, bg = colors.none },
        -- Git highlights
        GitSignsAdd = { fg = colors.green },
        GitSignsChange = { fg = colors.yellow },
        GitSignsDelete = { fg = colors.red },
        -- LSP highlights
        LspReferenceText = { bg = colors.surface1 },
        LspReferenceRead = { bg = colors.surface1 },
        LspReferenceWrite = { bg = colors.surface1 },
      }
    end,
    default_integrations = true,
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      notify = false,
      mini = {
        enabled = true,
        indentscope_color = "",
      },
      telescope = {
        enabled = true,
      },
      which_key = true,
      illuminate = {
        enabled = true,
        lsp = false,
      },
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
          ok = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
          ok = { "underline" },
        },
        inlay_hints = {
          background = true,
        },
      },
      -- Additional integrations
      mason = true,
      dap = true,
      dap_ui = true,
      flash = true,
      neotree = true,
      indent_blankline = {
        enabled = true,
        scope_color = "",
        colored_indent_levels = false,
      },
      markdown = true,
      semantic_tokens = true,
      treesitter_context = true,
      rainbow_delimiters = true,
      ufo = true,
      render_markdown = true,
      fzf = true,
      hop = false,
      leap = false,
      lightspeed = false,
      ts_rainbow = false,
      ts_rainbow2 = false,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
