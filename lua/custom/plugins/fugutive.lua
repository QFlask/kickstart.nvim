return {
  'tpope/vim-fugitive',
  cmd = { 'Git', 'G', 'Gdiffsplit', 'Glog', 'Gedit' }, -- optional lazy load
  keys = {
    { '<leader>gs', ':Git<CR>', desc = '[G]it [S]tatus' },
  },
}
