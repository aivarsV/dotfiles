set nocompatible              " be iMproved, required
set wildmenu
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
filetype off                  " required

set shell=/bin/bash
" set the runtime path to include Vundle and initialize
set rtp+=/usr/share/vim/vimfiles/plugin
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" status bar plugin and themes
Plugin 'vim-airline/vim-airline'
Plugin 'gkeep/iceberg-dark'

" Color scheme
Plugin 'https://github.com/cocopon/iceberg.vim'

" indent guides
Plugin 'nathanaelkane/vim-indent-guides'

" workspace manager plugin
Plugin 'thaerkh/vim-workspace'

" parentsys close when tiping
Plugin 'tpope/vim-surround'

" git integration
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

" fzf file and buffer picker
Plugin 'https://github.com/junegunn/fzf.vim.git'

" address book
Plugin 'aivarsV/complete_email.vim'

" spell check and LSP client
Plugin 'dense-analysis/ale'

" readline editing in command mode
Plugin 'https://github.com/ryvnf/readline.vim.git'

" all plugins must be defined before this
call vundle#end()            " required
filetype plugin indent on    " required

set rtp+=~/.vim/runtime

set updatetime=100
set relativenumber
set scrolloff=1
set cursorline
set number
syntax on
set background=dark
colorscheme iceberg
hi! Normal ctermbg=NONE guibg=NONE
hi! EndOfBuffer ctermbg=NONE guibg=NONE
set ts=2 sw=2 et
let g:indent_guides_enable_on_vim_startup = 1
let g:airline_theme='icebergDark'
let g:workspace_session_disable_on_args = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 1

set timeoutlen=1000 ttimeoutlen=0

" indentation colors
let g:indent_guides_auto_colors=0
hi IndentGuidesEven guibg=#1e2132 ctermbg=235
hi IndentGuidesOdd guibg=NONE ctermbg=NONE

" use pandoc for mmarkdown preview
let g:vim_markdown_preview_pandoc=1
let g:vim_markdown_preview_use_xdg_open=1

" set wiki directories
let g:vimwiki_list = []
" if available add project wiki as first
if filereadable('.wiki.vim')
    source .wiki.vim
    execute 'normal \<CR>'
endif

" Disable automatic linting
let g:ale_lint_on_text_changed=0
let g:ale_lint_on_insert_leave=0
let g:ale_lint_on_enter=0
let g:ale_lint_on_save=0
let g:ale_lint_on_filetype_changed=0
let g:ale_languagetool_options='-l en-GB'

" Disable backups for gopass secret editing
au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile
let g:complete_email_file=expand('~/.mail_addreses')
let g:complete_email_gpg_key = 'aivars@vaivods.lv'
" highlighting
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Cr>
nnoremap , :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
" Useful when browsing git repos
nnoremap <C-\> :Ggrep <cword><CR><CR>:cwindow<CR><C-w>k
" line numbers in folder listing
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
