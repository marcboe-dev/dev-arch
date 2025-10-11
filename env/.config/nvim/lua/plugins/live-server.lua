return {
  'barrett-ruth/live-server.nvim',
  build = 'npm install -g live-server', -- or "pnpm add -g live-server"
  cmd = { 'LiveServerStart', 'LiveServerStop' },
  config = true,
  keys = {
    {
      '<leader>ls',
      '<cmd>LiveServerStart<cr>',
      desc = 'Start Live Server',
    },
    {
      '<leader>lx',
      '<cmd>LiveServerStop<cr>',
      desc = 'Stop Live Server',
    },
    {
      '<leader>lc',
      function()
        -- letzte :messages-Zeile holen
        local msgs = vim.api.nvim_exec('messages', true)
        local last = msgs:match '([^\n]+)$' or ''

        -- URL aus der live-server Meldung ziehen
        local url = last:match 'on%s+(%d+%.%d+%.%d+%.%d+:%d+)'
          or last:match 'on%s+(localhost:%d+)'
          or last:match '(https?://%S+)'
          or last:match '(%d+%.%d+%.%d+%.%d+:%d+)'

        if url then
          if not url:match '^https?://' then
            url = 'http://' .. url
          end
          vim.fn.setreg('+', url)
          vim.notify('Copied URL: ' .. url)
        else
          vim.notify('No URL found in last message', vim.log.levels.WARN)
        end
      end,
      desc = 'Copy Live Server URL',
    },
  },
}
