"set packpath=/home/mirko/.vim/pack
set encoding=utf-8

syntax on
filetype plugin indent on

set tabstop=2
set expandtab
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" Plug 'neoclide/coc.nvim'
Plug 'ycm-core/YouCompleteMe'
Plug 'tpope/vim-dispatch'
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'gruvbox-community/gruvbox'
Plug 'kaicataldo/material.vim'
Plug 'dracula/vim'
Plug 'sickill/vim-monokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'embear/vim-localvimrc'
Plug 'sainnhe/edge'
"Plug 'cdelledonne/vim-cmake'
Plug 'benmills/vimux'
Plug 'sigidagi/vim-cmake-project'
Plug 'tpope/vim-obsession'
call plug#end()

set lazyredraw
let NERDTreeHighlightCursorline = 0

inoremap <F3> <ESC>:NERDTreeToggle<cr>
nnoremap <F3> <ESC>:NERDTreeToggle<cr>

"set termguicolors
colo gruvbox
let g:airline_powerline_fonts = 1 

let g:edge_style = 'aura'
let g:edge_enable_italic = 0
let g:edge_disable_italic_comment = 1

if has('termguicolors')
    set termguicolors
endif

set guifont=Hack\ 11
set background=dark
"colorscheme edge

let g:airline_theme='dark'

set signcolumn=yes
set nu

"localvimrc opcije
let g:localvimrc_sandbox=0
let g:localvimrc_ask=0

"YCM opcije

" Mapping to close the completion menu (default <C-y>)
let g:ycm_key_list_stop_completion = ['<C-x>']

" Set filetypes where YCM will be turned on
let g:ycm_filetype_whitelist = { 'cpp':1, 'h':2, 'hpp':3, 'c':4, 'cxx':5, 'in':6 }

" Close preview window after completing the insertion
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

let g:ycm_confirm_extra_conf = 0                 " Don't confirm python conf
let g:ycm_always_populate_location_list = 1      " Always populae diagnostics list
let g:ycm_enable_diagnostic_signs = 1            " Enable line highligting diagnostics
let g:ycm_open_loclist_on_ycm_diags = 1          " Open location list to view diagnostics

let g:ycm_max_num_candidates = 20                " Max number of completion suggestions
let g:ycm_max_num_identifier_candidates = 10     " Max number of identifier-based suggestions
let g:ycm_auto_trigger = 1                       " Enable completion menu
let g:ycm_show_diagnostic_ui = 1                 " Show diagnostic display features
let g:ycm_error_symbol = '>>'                    " The error symbol in Vim gutter
let g:ycm_enable_diagnostic_signs = 1            " Display icons in Vim's gutter, error, warnings
let g:ycm_enable_diagnostic_highlighting = 1     " Highlight regions of diagnostic text
let g:ycm_echo_current_diagnostic = 1            " Echo line's diagnostic that cursor is on

" Open vim-dispatch window and scroll to bottom
nnoremap    <C-m>m    :Copen<CR> <bar> G
" Build debug and release targets
let g:buildfolder=getcwd()."/bin"
let g:debugbuildcmd=" cmake -B=".g:buildfolder."/Debug -S=.&&make -C".g:buildfolder."/Debug"
"echo g:debugbuildcmd
nnoremap    <C-m>bd   :Dispatch! cmake -B=build/Debug -DCMAKE_BUILD_TYPE=Debug -S=.&&make -C build/Debug&&ln -sf build/Debug/compile_commands.json compile_commands.json<CR>
nnoremap    <C-m>br   :Dispatch! cmake -B=build/Release -DCMAKE_BUILD_TYPE=Release -S=.&&make -C build/Release&&ln -sf build/Release/compile_commands.json compile_commands.json<CR>

" Map <F6> to the Debug executable with passed filename
function SetBinaryDebug(filename)
    let bpath = getcwd() . "/bin/Debug/" . a:filename
    execute "nnoremap <F6> :Dispatch "
            \ bpath
            \ . " <CR> <bar> :Copen<CR>"
    echo "<F6> will run: " . bpath
endfunction

" Map <F7> to the Release executable with passed filename
function SetBinaryRelease(filename)
    let bpath = getcwd() . "/bin/Release/" . a:filename
    execute "nnoremap <F7> :Dispatch "
                \ bpath
                \ . "<CR> <bar> :Copen<CR>"
    echo "<F7> will run: " . bpath
endfunction

let g:localvimrc_event=["VimEnter"]

let g:projectname = matchstr(readfile(expand('CMakeLists.txt')), 'set(_PROJECT_NAME_')
let g:projectname = matchstr(g:projectname, ' \zs.\{-}\ze)')
"system("awk '$1 ~ /set(_PROJECT_NAME_/ {gsub(")", ""); print $2}' CMakeLists.txt | tr -d '\\n\'")
"let g:projectname = system("grep -oP \'set\\(project\\(\\K.*?(?= )\' CMakeLists.txt \| tr -d \'\\n\'")

nnoremap <S-tab> :tabn<CR>
inoremap <S-tab> <ESC> :tabn<CR>

call SetBinaryRelease(g:projectname)
call SetBinaryDebug(g:projectname)

"autocmd VimEnter * NERDTree

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if @% != ""  && getcmdwintype() == '' | silent NERDTreeMirror | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" autocmd VimEnter * wincmd w
"
set mouse=a
