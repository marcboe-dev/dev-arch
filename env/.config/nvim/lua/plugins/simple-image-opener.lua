-- Simple image viewer for WSL2 - Opens images in Windows default app
return {
  -- Only load on Ubuntu/WSL
  enabled = function()
    return vim.fn.has 'wsl' == 1 or vim.fn.executable 'wslview' == 1
  end,
  'nvim-lua/plenary.nvim',
  config = function()
    -- Function to open file under cursor in Windows
    local function open_in_windows()
      local file = vim.fn.expand '<cfile>'

      if file == '' then
        vim.notify('No file under cursor', vim.log.levels.WARN)
        return
      end

      -- Get absolute path if relative
      if not file:match '^/' and not file:match '^%a:' and not file:match '^https?://' then
        local current_dir = vim.fn.expand '%:p:h'
        file = current_dir .. '/' .. file
      end

      -- Check if it's an image
      local is_image = file:match '%.png$' or file:match '%.jpg$' or file:match '%.jpeg$' or file:match '%.gif$' or file:match '%.webp$' or file:match '%.bmp$'

      if is_image then
        -- Open with Windows default app
        local cmd = string.format("wslview '%s' 2>/dev/null &", file)
        vim.fn.system(cmd)
        vim.notify('Opening image in Windows viewer', vim.log.levels.INFO)
      else
        vim.notify('Not an image file', vim.log.levels.WARN)
      end
    end

    -- Keymap: gx to open file under cursor in Windows
    vim.keymap.set('n', 'gx', open_in_windows, {
      desc = 'Open file under cursor in Windows default app',
      silent = true,
    })
  end,
}
