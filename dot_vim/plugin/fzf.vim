" Code borrowed from https://github.com/junegunn/fzf.vim
command! -bar -bang -nargs=? -complete=buffer Buf call fzf_vim#buffers(<q-args>, <bang>0)
