let g:vimwiki_map_prefix = '<leader>v'
"===[ Setting up Wim ]==="
function! VimplugInstaller()
  let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
  if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endfunction

function! DownloadCheat()
    let local_file_path = expand('~/.vim/cheat40.txt')
    let github_url = 'https://raw.githubusercontent.com/wolandark/wim/Devel/cheat40.txt'
    if !filereadable(local_file_path)
        echo "Downloading cheat40.txt..."
        execute 'silent !curl -fLo ' . shellescape(local_file_path) . ' --create-dirs ' . shellescape(github_url)
        if filereadable(local_file_path)
            echo "Downloaded cheat40.txt successfully."
        else
            echoerr "Failed to download cheat40.txt."
        endif
    endif
endfunction

function! SetupWim()
  call VimplugInstaller()
  call DownloadCheat()
endfunction
call SetupWim()

"===[ Encoding ]==="
set encoding=utf-8
"===[ Plugins ]==="
call plug#begin()
Plug 'ryanoasis/vim-devicons'
Plug 'https://github.com/Rican7/php-doc-modded.git'
Plug 'mattn/emmet-vim'
" Plug 'wolandark/Mitra-Vim'
Plug 'wolandark/NotePad-Vim'
Plug 'wolandark/Pool-Vim'
Plug 'wolandark/ColorschemeFromHell-Vim'
Plug 'wolandark/vim-live-server'
Plug 'wolandark/vim-loremipsum'
Plug 'wolandark/redundant'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
" Plug 'https://gitlab.com/HiPhish/info.vim.git'
" Plug 'https://github.com/alx741/vinfo.git'
Plug 'yegappan/mru'
Plug 'DougBeney/pickachu'
Plug 'alvan/vim-closetag'
Plug 'voldikss/vim-floaterm'
Plug 'lifepillar/vim-cheat40'
Plug 'ptzz/lf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
" Plug 'https://github.com/ap/vim-buftabline.git'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'https://github.com/rhysd/clever-f.vim.git'
Plug 'https://github.com/justinmk/vim-sneak.git'
" Plug 'https://github.com/vim-scripts/Vimacs.git'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'https://github.com/godlygeek/tabular.git'
Plug 'mhinz/vim-startify'
Plug 'https://github.com/markonm/traces.vim.git'
Plug 'vimwiki/vimwiki'
" Plug 'https://github.com/rstacruz/sparkup.git'
Plug 'https://github.com/Valloric/MatchTagAlways.git'
Plug 'https://github.com/preservim/tagbar.git'
Plug 'junegunn/vim-peekaboo'
Plug 'https://github.com/907th/vim-auto-save.git'
Plug 'https://github.com/sedm0784/vim-you-autocorrect.git'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'fcpg/vim-fahrenheit'

Plug 'chriskempson/base16-vim'
" Plug 'https://github.com/ap/vim-css-color.git'
" Plug 'neoclide/coc.nvim', {'branch': 'release','for':['javascript', 'C', 'sh']}
" Plug 'prettier/vim-prettier', {
"   \ 'do': 'yarn install --frozen-lockfile --production',
"   \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html', 'go'] }

Plug 'iibe/gruvbox-high-contrast'
Plug 'fcpg/vim-farout'

call plug#end()

"===[ Auto Save ]==="
" function! ToggleAutoSave()
"     if g:auto_save == 1
"         let g:auto_save = 0
"     else
"         let g:auto_save = 1
"     endif
" endfunction
nnoremap <nowait>\a :call AutoSaveToggle()<CR>

"===[ Theme ]==="
set background=dark
" Inspect $TERM instead of t_Co
if &term =~ '256color'
	" Enable true (24-bit) colors instead of (8-bit) 256 colors.
	if has('termguicolors')
		let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
		let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
		let &t_TI = ""
		let &t_TE = ""
		set termguicolors
		set mouse=a
		colorscheme catppuccin_mocha
	endif
	if expand('%:e') == 'wiki'
		colorscheme base16-horizon-dark
		let &t_TI = ""
		let &t_TE = ""
        autocmd VimEnter * :set rnu!
	else
		colorscheme catppuccin_mocha
		let &t_TI = ""
		let &t_TE = ""
	endif
endif

if has('gui_running')
	set mouse=a
	set guicursor+=a:blinkon0
	set guifont=FiraCodeNerdFont\ 14
	colorscheme catppuccin_mocha
endif

"===[ Curosr Shape ]==="
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

"===[ Startify ]==="
" let g:startify_padding_left = 3
let g:startify_disable_at_vimenter = 0
let g:startify_custom_header = [
			\'                        ',
			\'    ██╗    ██╗██╗███╗   ███╗',
			\'    ██║    ██║██║████╗ ████║',
			\'    ██║ █╗ ██║██║██╔████╔██║',
			\'    ██║███╗██║██║██║╚██╔╝██║',
			\'    ╚███╔███╔╝██║██║ ╚═╝ ██║',
			\'     ╚══╝╚══╝ ╚═╝╚═╝     ╚═╝',
			\ ]
let g:startify_custom_footer = split(system('fortune'), '\n') + ['','']
" let g:startify_custom_footer =
           " \ ['RIP Bram Moolenaar', '', 'Wim, an opionated Vim configuration', 'By Wolandark', ]
"Bookmarks. Syntax is clear.add yours
let g:startify_bookmarks = [ {'B': '~/.bashrc'},{'V': '~/.vimrc'}]
let g:startify_lists = [
      \ { 'type': 'bookmarks' , 'header': ['   Bookmarks']      } ,
      \ { 'type': 'files'     , 'header': ['   Recent'   ]      } ,
      \ { 'type': 'sessions'  , 'header': ['   Sessions' ]      } ,
      \ { 'type': 'commands'  , 'header': ['   Commands' ]      } ,
      \ ]

hi StartifyBracket ctermfg=240
hi StartifyFile    ctermfg=147
hi StartifyFooter  ctermfg=240
hi StartifyHeader  ctermfg=114
hi StartifyNumber  ctermfg=215
hi StartifyPath    ctermfg=245
hi StartifySlash   ctermfg=240
hi StartifySpecial ctermfg=240

"===[ Clever F ]==="
let g:clever_f_across_no_line=1
let g:clever_f_ignore_case=1
let g:clever_f_mark_char_color='StatuslineTermNC'

"===[ Clipboard ]==="
set clipboard=unnamedplus,unnamed

"===[ Remember Cursor Position ]==="
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"===[ Persistent Undo History ]==="
function! EnsureVimhisExists()
    let vimhis_path = expand('~/.vimhis')

    if !isdirectory(vimhis_path)
        call mkdir(vimhis_path, 'p')
        echo "Created directory: " . vimhis_path
    " else
        " echo "Directory already exists: " . vimhis_path
    endif
endfunction
call EnsureVimhisExists()

if has('persistent_undo')
	" Save all undo files in a single location (less messy, more risky)...
	set undodir=$HOME/.vimhis
	" Save a lot of back-history...
	set undolevels=5000
	" Actually switch on persistent undo
	set undofile
endif

" set foldenable
set emoji
set autochdir
set hidden
set ma
set conceallevel=0
set concealcursor=n
set so=6
set nocompatible
set modifiable
set autoread
set cmdheight=1 
set foldmethod=manual
set foldlevel=0
set foldclose=all
set path+=**
set noswapfile
set autoindent
set ic
set incsearch
set smartcase
set noerrorbells
set novisualbell
set t_vb=
set noeb vb t_vb=
set relativenumber
set number
set hlsearch
nnoremap <silent><ESC> <ESC>:noh<CR><ESC>
set termbidi
set autowrite
set autowriteall
set laststatus=2
set showtabline=2
set noshowmode
set colorcolumn=80
set shiftwidth=4
set tabstop=4
syntax on
filetype plugin indent on

"===[ ZWNJ ]==="
call matchadd('Conceal', '\%u200c', 10, -1, {'conceal':'|'})
set conceallevel=2 concealcursor=nv

"===[ NETRW ]==="
" Start with dotfiles hidden
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" Usual things
let g:netrw_special_syntax = 3
let g:netrw_banner = 0
let g:netrw_keepdir=0

" Syntax Item In Ststus
function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

"===[ Lightline Statusbar ]==="
let g:lightline = {
          \ 'colorscheme': 'catppuccin_mocha',
		  \ 'active': {
		  \ 'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'filetype' ], [ 'bufname' ], ['syntaxitem'] ],
		  \ 'left': [ [ 'mode' ], [ 'readonly', 'absolutepath', 'modified', 'gitbranch' ] ],
		  \ },
		  \ 'component_function': {
		  \ 'gitbranch': 'FugitiveHead',
		  \ 'syntaxitem': 'SyntaxItem',
		  \ },
		  \ 'component': {
		  \ 'charvaluehex': '0x%B',
		  \ 'lineinfo': '%l\%L',
		  \ },
		  \ 'tabline': {
		  \   'left': [ ['buffers'] ],
		  \   'right': [ ['close'] ]
		  \ },
		  \ 'component_expand': {
		  \   'buffers': 'lightline#bufferline#buffers'
		  \ },
		  \ 'component_type': {
		  \   'buffers': 'tabsel'
		  \ }
		  \ }

let g:lightline.separator={ 'left': "\ue0b0", 'right': "\ue0b2" }
let g:lightline.subseparator={ 'left': "\ue0b1", 'right': "\ue0b3" }

let g:lightline#bufferline#enable_devicons=1
let g:lightline#bufferline#enable_nerdfont=1
"===[ SpellCheking ]==="
nnoremap <F6> :setlocal spell! spelllang=en_us<CR>
hi SpellBad ctermfg=red guifg=red
set wildmode=longest,list,full

function! FixSpell()
	normal! 1z=<CR>
endfunction
nnoremap gs :call FixSpell()<CR>
" map <leader>z :call FixSpell()<CR>

"===[ Custom Mappings ]==="
let mapleader =" "

"===[ Floaterm ]==="
let g:floaterm_autoclose = 1
nnoremap \t  :FloatermToggle<CR>
nnoremap \q :FloatermKill <CR>
nnoremap \n  :FloatermNext<CR>
nnoremap \p  :FloatermPrev<CR>

" Filemanagers
nnoremap \v :FloatermNew! vifm <CR>
nnoremap \ra :FloatermNew! ranger <CR>
" Terminal Right/Bottom
nnoremap \tr :FloatermNew --wintype=vsplit --position=right --width=0.4
nnoremap \tb :FloatermNew --wintype=split --position=bottom --height=0.2

" Run Go Files
nnoremap \rg :FloatermNew --autoclose=0 --wintype=split --position=bottom --height=0.3 go run % <Cr>
" Run Bash Files
nnoremap \rb :FloatermNew --autoclose=0 --wintype=split --position=bottom --height=0.3 bash % <CR>
" Run NodeJs Files
nnoremap \rj :FloatermNew --autoclose=0 --wintype=split --position=bottom --height=0.3 node % <CR>
" Run Python Files
nnoremap \rp :FloatermNew --autoclose=0 --wintype=split --position=bottom --height=0.3 python % <CR>

" Bilingual 
inoremap <C-p> <C-o>:SwitchKeymap<CR>
nnoremap <C-p> :SwitchKeymap<CR>

" Switch Buffers
nnoremap <PageUp> :bn<Cr>
nnoremap <PageDown> :bp<CR>

" Center Cursor Easier
nnoremap <C-m> gM

" Border Around 
nnoremap <leader>\ :.!toilet -w 200 -f term -F border<CR>

" nnoremap <leader>e :Ex <CR>
nnoremap <space>e <Cmd>CocCommand explorer<CR>

nnoremap <leader>T :tabnew file <CR>
nnoremap <leader>mk :mkview <CR>

nnoremap <leader>i :Startify <CR> 

"adding empty line above and below cursor
nnoremap <leader>S :normal! O<ESC>jo<ESC>kzzk<CR>
nnoremap <leader>[ :normal! O<ESC>j
nnoremap <leader>] :normal! o<ESC>k

"Quick save and source 
nnoremap <nowait><leader>w :w!<CR>
nnoremap <leader>so :w<CR>:source %<CR>

vnoremap <leader>k :m .-2<CR>
vnoremap <leader>j :m .+1<CR>
nnoremap <leader>k :m .-2<CR>
nnoremap <leader>j :m .+1<CR>
inoremap <nowait> jj <ESC>

" VimPlug
nnoremap <leader>pli :PlugInstall<CR>
nnoremap <leader>plc :PlugClean<CR>
nnoremap <leader>plu :PlugUpdate<CR>
nnoremap <leader>plg :PlugUpgrade<CR>

"===[ Split Navigation  ]==="
set splitbelow splitright
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-LEFT> <C-w>h
nnoremap <C-DOWN> <C-w>j
nnoremap <C-UP> <C-w>k

nnoremap <C-RIGHT> <C-w>l
nnoremap <leader>R <C-w>R  "rotate window up/left
nnoremap <leader>r <C-w>r  "rotate window down/right

"shift arrows to resize splits
nnoremap <s-Right> :vertical resize +5 <CR>
nnoremap <s-LEFT> :vertical resize -5 <CR>
nnoremap <s-UP> :resize +5 <CR>
nnoremap <s-DOWN> :resize -5 <CR>

"Alt arrows to go to next/previous tab
nnoremap <M-Left> :tabprevious<CR>
nnoremap <M-Right> :tabnext<CR>

"Keybindings for tab navigation with leader and number
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tablast<CR>
nnoremap <leader>x :tabclose<CR>
nnoremap <leader>tm :tabmove<CR>

" FZF 🙂 
nnoremap \c :Colors<CR>
nnoremap <nowait><leader>b :Buffers<CR>
nnoremap <nowait><leader>ff :Files<CR>
nnoremap <nowait><leader>W :Windows<CR>
nnoremap <nowait><leader>h :History<CR>
nnoremap <nowait><leader>hc :History:<CR>
nnoremap <nowait><leader>rg :Rg <CR>
nnoremap <nowait><leader>li :Lines <CR>
" nnoremap <nowait><leader>bli :BLines <CR>
" nnoremap <nowait><leader>ju :Jumps <CR>
nnoremap <nowait><leader>ma :Marks <CR>
nnoremap <nowait><leader>M :Maps <CR>
nnoremap <nowait><leader>sn :Snippets <CR>
nnoremap <nowait><leader>com :Commands <CR>
nnoremap <nowait><leader>ag :Ag <CR>
nnoremap <nowait><leader>tag :Tags <CR>

" Tabular
" if exists(":Tabularize")
vnoremap \at :Tabularize /\|<CR> 
vnoremap \ta :Tabularize /
vnoremap \ah :Tabularize /=<CR> 
" endif

" Enuch
nnoremap <nowait><leader>ch :Chmod +x <CR>
nnoremap <nowait><leader>suw :SudoWrite <CR>
nnoremap <nowait><leader>sue :SudoEdit <CR>
nnoremap <nowait><leader>rm :Remove <CR>
nnoremap <nowait><leader>del :Delete! <CR>
nnoremap <nowait><leader>mv :Move 
nnoremap <nowait><leader>dup :Duplicate 
nnoremap <nowait><leader>mkd :Mkdir

"===[ Live Server ]==="
nnoremap <F2> :StartBrowserSync <CR>
nnoremap <F3> :KillBrowserSync <CR>

"===[ GitGutter ]==="
let g:gitgutter_enabled = 1
let g:gitgutter_sign_added = '√' 
let g:gitgutter_sign_modified = '+'
let g:gitgutter_sign_removed = '×'
let g:gitgutter_sign_removed_first_line ='▲'
let g:gitgutter_sign_modified_removed = '-'

"===[ HTML ]==="
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
let g:html_indent_attribute = 1
let g:html_indent_inctags = "html,body,head,tbody"

function! EnsureXMLExists()
  let xml_path = expand('~/.vim/skeleton.xml')
  if !filereadable(xml_path)
    let lines = [
          \ '<!DOCTYPE html>',
          \ '<html lang="en">',
          \ '  <head>',
          \ '    <meta charset="UTF-8">',
          \ '    <meta http-equiv="X-UA-Compatible" content="IE=edge">',
          \ '    <meta name="viewport" content="width=device-width, initial-scale=1.0">',
          \ '    <title>New Page</title>',
          \ '    <link rel="stylesheet" href="style.css">',
          \ '  </head>',
          \ '  <body>',
          \ '    <h1><header>Hello World</header></h1>',
          \ '   <script src="app.js"></script>',
          \ '  </body>',
          \ '</html>',
          \ ]
    call writefile(lines, xml_path)
    " echo "Created file with content: " . xml_path
    " else
    " echo "File already exists: " . xml_path
  endif
endfunction
call EnsureXMLExists()

augroup Xml
    au BufNewFile *.html 0r ~/.vim/skeleton.xml
    " set filetype=html
augroup end

"===[ Emmet ]==="
let g:user_emmet_install_global = 1
let g:user_emmet_leader_key = '<C-z>'

"===[ Close Tag ]==="
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.md'
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:closetag_shortcut = '>'

"===[ Tagbar ]==="
let g:tagbar_type_vimwiki = {
          \   'ctagstype':'vimwiki'
          \ , 'kinds':['h:header']
          \ , 'sro':'&&&'
          \ , 'kind2scope':{'h':'header'}
          \ , 'sort':0
          \ , 'ctagsbin':'/home/woland/vwtags.py'
          \ , 'ctagsargs': 'default'
          \ }
let g:tagbar_autofocus = 1
let g:tagbar_autoupdate = 1

"===[ VimWiki ]==="
let wiki = {}
let g:vimwiki_global_ext = 0
let g:vimwiki_root_dir = '~/vimwiki/'
let wiki.nested_syntaxes = {'php': 'php', 'bash': 'bash', 'python': 'python', 'c++': 'cpp', 'javascript': 'javascript', 'awk': 'awk'}
let g:vimwiki_list = [wiki]
" nmap <leader>vw <Plug>VimwikiIndex

command! Diary VimwikiDiaryIndex
augroup vimwikigroup
    autocmd!
    " automatically update links on read diary
    autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end

"===[ Terminal ]==="
let g:terminal_height = -10
set termwinsize=10x200
nnoremap <leader>' :botright terminal<CR>
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-Down> <C-\><C-n><C-w>j
tnoremap <C-Up> <C-\><C-n><C-w>k
" tnoremap <C-PageUp> :tabprevious<CR>
" tnoremap <C-PageDown> :tabnext<CR>
set shell=/bin/bash
" Clear Terminal in BG
nnoremap \l :!clear<CR><CR>

"===[ Runtime Macros ]==="
runtime macros/emoji-ab.vim
runtime macros/justify.vim 
" use _j to activate
runtime macros/matchit.vim

"===[ Markdown Preview ]==="
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 1
let g:mkdp_open_ip = ''
let g:mkdp_browser = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'
let g:mkdp_filetypes = ['markdown']
let g:mkdp_theme = 'dark'

"===[ SNIPPETS ]==="
"Use Ctrl j key to trigger the snippets, default was TAB but that conflicts with
"the Completion trigger see :h keycodes to change this to sth else 
"use Ctrl j and k to move visually within the snippet that was just triggered
"Ctrl l lists the available snippets
let g:UltiSnipsExpandTrigger='<C-j>'
let g:UltiSnipsListSnippets='<C-l>'
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-k>'
let g:copypath_copy_to_unnamed_register = 1

"===[ CleverF ]==="
let g:clever_f_mark_cursor=1
let g:clever_f_mark_char=1
let g:clever_f_mark_cursor_color = "DiffDelete"
let g:clever_f_mark_char_color = "SpellBad"
let g:clever_f_across_no_line=0
let g:clever_f_ignore_case=0
let g:clever_f_smart_case=0
let g:clever_f_show_prompt=0

"===[ Disable a lot of unnecessary internal plugins ]==="
" let g:loaded_2html_plugin = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_logipat = 1
let g:loaded_rrhelper = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_tarPlugin = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zipPlugin = 1

"===[Coc.nvim]==="
" let g:coc_node_path = "/usr/bin/node"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><s-tab> coc#pum#visible() ? coc#pum#prev(1) : "\<c-h>"

"===[ Coc-Explorer ]==="
" set up coc-explorer to open in the current directory
let g:coc_explorer_global_mirror = 0
let g:coc_explorer_disable_default_keybindings = 1
let g:coc_explorer_global_root = 'current'

"===[ Coc Global Extensions ]==="
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-sh',
  \ 'coc-explorer',
  \ 'coc-vimlsp',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-pyright'
\ ]

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
" List code actions available for the current buffer
nmap <leader>ca  <Plug>(coc-codeaction)

nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')
" Formatting selected code
vmap <leader>f  <Plug>(coc-format-selected)

" Navigations
" nmap <Leader>o <Plug>(coc-definition)
" nmap <Leader>O <Plug>(coc-type-definition)
" nmap <Leader>I <Plug>(coc-implementation)
" nmap <Leader>R <Plug>(coc-references)

" Hover
" nmap K :call <SID>show_documentation()<CR>
" function! s:show_documentation()
" 	if (index(['vim','help'], &filetype) >= 0)
" 		execute 'h '.expand('<cword>')
" 	else
" 		call CocAction('doHover')
" 	endif
" endfunction
" Use K to show documentation in preview window

"===[ Coc-Snippets ]==="
"Use <C-l> for trigger snippet expand.
" imap <C-l> <Plug>(coc-snippets-expand)

"Use <C-j> for select text for visual placeholder of snippet.
"vmap <C-j> <Plug>(coc-snippets-select)

"Use <C-j> for jump to next placeholder, it's default of coc.nvim
"let g:coc_snippet_next = '<c-j>'

"Use <C-k> for jump to previous placeholder, it's default of coc.nvim
"let g:coc_snippet_prev = '<c-k>'

"Use <C-j> for both expand and jump (make expand higher priority.)
"imap <C-j> <Plug>(coc-snippets-expand-jump)

"Use <leader>x for convert visual selected code to snippet
"xmap <leader>x  <Plug>(coc-convert-snippet)

"===[ Compile and Run C ]==="
nnoremap <F8> :call CompileAndRun()<CR>

function! CompileAndRun()
  let current_file = expand('%')
  let file_name = fnamemodify(current_file, ':t:r')
  let compile_cmd = 'gcc ' . current_file . ' -o ' . file_name . ' && ./' . file_name
  execute '!'.compile_cmd
endfunction

"===[ Execute From Vim ]==="
function! ExecuteCustomCommand()
    if &ft ==# 'python'
        execute 'RPy'
    elseif &ft ==# 'sh'
        execute 'RB'
	elseif &ft ==# 'javascript'
		execute 'RJs'
	elseif &ft ==# 'php'
		execute 'RPHP'
	elseif &ft ==# 'go'
		execute 'RGo'
    endif
endfunction

" Define several language specific Run commands 
augroup custom_commands
    au!
    au FileType python command! RPy :!python3 %
    au FileType sh command! RB :!bash %
	au FileType javascript command! RJs :!node %
	au FileType go command! RGo :!go run %
	au FileType php command! RPHP :!php %
    nnoremap <F12> :call ExecuteCustomCommand()<CR>
augroup end

"=== [ Bilingual Settings ] ==="
function! SetPersianKeymapAndCursorColor()
    set keymap=persian
	silent !echo -ne "\033]12;cyan\007"
	redraw!
	autocmd VimLeave * silent !echo -ne "\033]112\007"
endfunction
command! SetPersian call SetPersianKeymapAndCursorColor()

function! SetBackToEng()
    set keymap=
	silent !echo -ne "\033]112\007"
	redraw!
endfunction
command! SetEng call SetBackToEng()

let g:alt_keymap = 'persian'
let g:alt_enabled = 1

function! CallToggleKeymap()
    if g:alt_enabled
        call ToggleKeymap()
    endif
endfunction

function! ToggleKeymap()
    if &keymap == ''
        execute 'setlocal keymap=' . g:alt_keymap
            silent !echo -ne "\033]12;cyan\007"
            redraw!
            autocmd VimLeave * silent !echo -ne "\033]112\007"
    else
        set keymap= 
            silent !echo -ne "\033]112\007"
            redraw!
    endif
endfunction

command! SwitchKeymap call CallToggleKeymap()
 
function! ListKeymapFiles()
    :Explore $VIMRUNTIME/keymap/
endfunction

iab sh: #!/bin/sh
iab shs: #!/bin/sh
iab bsh: #!/usr/bin/env bash
iab pys: #!/usr/bin/env python
iab br <br>
iab hr <hr>
iab Lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent at
\ massa et est vulputate sollicitudin vitae at libero. Pellentesque iaculis neque
\ diam, vulputate tempor est ullamcorper quis. Lorem ipsum dolor sit amet, consectetur
\ adipiscing elit. Vivamus sed purus risus. Nunc vitae augue sit amet magna semper
\ efficitur quis at erat. Suspendisse commodo sem at neque feugiat auctor. Praesent
\ pretium tellus odio. Integer a facilisis nibh. Duis hendrerit nibh quis turpis
\ vulputate aliquam id quis nibh. Suspendisse ut quam quis arcu sodales luctus.
\ Ut id sagittis ex. Praesent facilisis velit blandit dictum luctus. Cras in erat
\ malesuada nisi dignissim tempus. Ut in placerat tortor.

"===[ LF ]==="
let g:lf_map_keys = 0
let g:lf_width = 100
let g:lf_height = 40
nnoremap <leader>lf :Lf<CR>

"===[ Custom Cheat40.txt ]==="
let g:cheat40_use_default = 0

"===[ Hexokinase ]==="
" All possible values
let g:Hexokinase_optInPatterns = [
\     'full_hex',
\     'triple_hex',
\     'rgb',
\     'rgba',
\     'hsl',
\     'hsla',
\     'colour_names'
\ ]
let g:Hexokinase_highlighters = [ 'backgroundfull' ]

"===[ Help ]==="
command! -nargs=1 -complete=help H :h <args> | only
command! -nargs=1 -complete=help Hv :vert h <args>
command! -nargs=1 -complete=help Hh :vert h <args>

"===[ Never Leave Vim ]==="
nnoremap \w :bwipeout <CR>

"===[ MRU }==="
nnoremap \h :MRU <CR>

"===[ Indentlines ]==="
function! ToggleIndentLine()
    if &list
        set nolist
    else
        exe 'setlocal listchars=tab:\|\ ,multispace:\|' . repeat('\ ', &sw - 1)
        set list
    endif
endfunction

nnoremap \rnb :!erb -T - % > %<.vim 

augroup go
    au BufNewFile *.go 0r ~/.vim/skeleton.go
augroup end

" Replace Easier
" function! ReplaceParams(param1, param2)
    " execute '%s/' . a:param1 . '/' . a:param2 . '/g'
" endfunction

" command! -nargs=* S call ReplaceParams(<f-args>)

"===[ Auto Pairs ]==="
" let g:AutoPairsFlyMode = 1
" let g:AutoPairsShortcutBackInsert = '<M-b>'
" let g:AutoPairs = {'(':')', '[':']', '{':'}'}

"===[ PHP ]==="
inoremap 4 $
inoremap $ 4

" for sql syntax highlighting in php files
let php_sql_query = 1
let php_htmlInStrings = 1

" for trimming extra $ with phpactor
autocmd FileType php set iskeyword+=$

augroup php
    au BufNewFile *.php 0r ~/.vim/skeleton.php
augroup end

" Comment with \\
autocmd FileType php setlocal commentstring=/\/\ %s

" sneak 
nmap \S <Plug>Sneak_S
let g:sneak#label = 1

