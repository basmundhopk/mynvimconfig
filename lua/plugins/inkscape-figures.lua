return {
  "gillescastel/inkscape-figures",
  ft = { "tex", "latex" },
  dependencies = { "lervag/vimtex" },
  config = function()
    -- Key mappings for inkscape-figures
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "tex", "latex" },
      callback = function()
        local opts = { buffer = true, silent = true }

        -- Create figure: Type figure title on a line, then press Ctrl+F in insert mode
        vim.keymap.set("i", "<C-f>", function()
          local line = vim.fn.getline(".")
          local root = vim.b.vimtex and vim.b.vimtex.root or vim.fn.expand("%:p:h")

          -- Execute the inkscape-figures create command
          local result = vim.fn.system(string.format('inkscape-figures create "%s" "%s/figures/"', line, root))

          -- Replace the current line with the LaTeX figure code
          local figure_name = line:gsub("%s+", "-"):gsub("[^%w%-]", ""):lower()
          local latex_code = {
            "\\begin{figure}[ht]",
            "    \\centering",
            string.format("    \\incfig[0.8]{%s}", figure_name),
            string.format("    \\caption{%s}", line),
            string.format("    \\label{fig:%s}", figure_name),
            "\\end{figure}",
          }

          -- Replace current line with the figure code
          vim.api.nvim_set_current_line(latex_code[1])
          for i = 2, #latex_code do
            vim.cmd("normal! o")
            vim.api.nvim_set_current_line(latex_code[i])
          end

          -- Open Inkscape in fullscreen with zoom to page
          local svg_path = string.format("%s/figures/%s.svg", root, figure_name)
          vim.fn.jobstart(
            string.format('open -a Inkscape "%s" --args --fullscreen --verb=ZoomPage', svg_path),
            { detach = true }
          )

          vim.cmd("write")
        end, opts)

        -- Edit figure: Press Ctrl+F in normal mode to select and edit a figure
        vim.keymap.set("n", "<C-f>", function()
          local root = vim.b.vimtex and vim.b.vimtex.root or vim.fn.expand("%:p:h")
          vim.cmd(string.format([[silent exec '!inkscape-figures edit "%s/figures/" > /dev/null 2>&1 &']], root))
          vim.cmd("redraw!")
        end, opts)
      end,
    })

    -- Optional: Set up user commands for better integration
    vim.api.nvim_create_user_command("InkscapeFiguresWatch", function()
      vim.fn.jobstart("inkscape-figures watch", { detach = true })
      print("Started inkscape-figures watcher")
    end, {})

    vim.api.nvim_create_user_command("InkscapeFiguresCreate", function(opts)
      local title = opts.args
      local root = vim.b.vimtex and vim.b.vimtex.root or vim.fn.expand("%:p:h")
      vim.cmd(string.format([[!inkscape-figures create "%s" "%s/figures/"]], title, root))
    end, { nargs = 1 })

    -- Create config.py to customize inkscape-figures behavior
    vim.api.nvim_create_user_command("InkscapeFiguresSetup", function()
      local config_dir = vim.fn.expand("~/.config/inkscape-figures")
      vim.fn.mkdir(config_dir, "p")

      local config_content = [[
import subprocess
import os

def latex_template(name, title):
    return '\n'.join((
        r"\begin{figure}[ht]",
        r"    \centering",
        rf"    \incfig[0.8]{{{name}}}",
        rf"    \caption{{{title}}}",
        rf"    \label{{fig:{name}}}",
        r"\end{figure}"
    ))

# Custom function to open Inkscape with fullscreen and zoom to page
def open_inkscape(path):
    # Use AppleScript to open Inkscape in fullscreen
    applescript = f'''
    tell application "Inkscape"
        open POSIX file "{path}"
        activate
        tell application "System Events"
            tell process "Inkscape"
                keystroke "f" using {{control down, command down}}
                delay 0.5
                keystroke "4"
            end tell
        end tell
    end tell
    '''
    subprocess.run(['osascript', '-e', applescript])
]]

      local config_path = config_dir .. "/config.py"
      local file = io.open(config_path, "w")
      if file then
        file:write(config_content)
        file:close()
        print("Created inkscape-figures config at: " .. config_path)
      else
        print("Failed to create config file")
      end
    end, {})
  end,
}
