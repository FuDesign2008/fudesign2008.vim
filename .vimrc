set nocompatible        " must be first line
" @see https://blog.csdn.net/njnu_mjn/article/details/7935103
let $LANG='en'
set langmenu=en
" FuDesign2008's vimrc

" Environment {
    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        let g:is_win = has('win32') || has('win64')
        if g:is_win
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
          " use zsh as default shell
          " 1. Conflict with fzf.vim， @see https://github.com/junegunn/fzf.vim/issues/1432
          " 2. ctrlp.vim is not work
          " set shell=D:\\Program\ Files\\Git\usr\\bin\\zsh.exe\ -i
        else
            " use bash as the default shell for vim
            " @see http://dailyvim.tumblr.com/post/66708941289/fish
            " set shell=/bin/bash
            " @see https://stackoverflow.com/questions/11415428/terminal-vim-not-loading-zshrc
            set shell=zsh\ -i
        endif
    " }

    " Setup Bundle Support {
    " The next three lines ensure that the ~/.vim/bundle/ system works
        filetype on
        filetype off
        set runtimepath+=~/.vim/bundle/vundle
        call vundle#rc()
    " }
    " { for python3
    "  fix https://blog.csdn.net/f4prime/article/details/113783784
    "  @see https://zhuanlan.zhihu.com/p/139746816
    "  python -c "import sys; print(sys.path)"
    "
        let g:python3_in_scoop=expand('~/scoop/apps/python/3.10.4')
        let g:python3_dll_in_scoop=expand('~/scoop/apps/python/3.10.4/python310.dll')
        if isdirectory(g:python3_in_scoop)
            execute 'set pythonthreehome=' . g:python3_in_scoop
            execute 'set pythonthreedll=' . g:python3_dll_in_scoop
        endif
        unlet g:python3_in_scoop
        unlet g:python3_dll_in_scoop
    " }

" }

" Bundles {
    " Use local bundles if available {
        if filereadable(expand('~/.vimrc.bundles.local'))
            source ~/.vimrc.bundles.local
        endif
    " }
    " Use fork bundles if available {
        if filereadable(expand('~/.vimrc.bundles.fork'))
            source ~/.vimrc.bundles.fork
        endif
    " }
    " Use bundles config {
        if filereadable(expand('~/.vimrc.bundles'))
            source ~/.vimrc.bundles
        endif
    " }
" }

augroup vimrc
    autocmd!
augroup END

" General {
    set background=dark         " Assume a dark background

    " use automatic for performance
    " @see https://jameschambers.co.uk/vim-typescript-slow
    set regexpengine=0

    "if !has('gui')
        "set term=$TERM          " Make arrow and other keys work
    "endif
    filetype plugin indent on   " Automatically detect file types.
    " open omni completion
    " @see http://vim.wikia.com/wiki/Omni_completion
    set omnifunc=syntaxcomplete#Complete
    syntax on                   " syntax highlighting
    set synmaxcol=256
    "set mouse=a                 " automatically enable mouse usage
    "set mousehide               " hide the mouse cursor while typing
    set encoding=utf-8
    scriptencoding utf-8

    if has('clipboard')
        if has ('gui')
            if has('unnamedplus')
                 " for ubuntu
                set clipboard=unnamedplus
                " inspired by  https://github.com/erickzanardo/vim-xclip
                vmap <c-s-c> "+y
                vmap <c-s-x> "+x
                nmap <c-s-v> "+gP
            endif
        else
            " echomsg 'no clipboard feature, no clipboard shortcuts'
        endif
    else
        " echomsg 'no clipboard feature, no clipboard shortcuts'
    endif


    set noautochdir
    " Set to auto read when a file is changed from the outside
    set autoread
    set autowrite                  " automatically write a file when leaving a modified buffer
    "set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
    "set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
    "set virtualedit=onemore         " allow for cursor beyond last character
    set history=1000                " Store a ton of history (default is 20)
    "set spell                       " spell checking on
    set nospell
    " @see https://webpack.js.org/configuration/watch/
    set backupcopy=yes
    " Git commits, Subversion commits.
    autocmd vimrc FileType gitcommit,svn setlocal spell
    autocmd vimrc BufNewFile,BufReadPost *.md,*.mkd         set filetype=markdown
    autocmd vimrc BufNewFile,BufReadPost *.mmd,*.mermaid    set filetype=mermaid
    autocmd vimrc BufNewFile,BufReadPost *.conf             set filetype=conf
    autocmd vimrc BufNewFile,BufReadPost *.vm               set filetype=html
    "autocmd vimrc FileType text,wiki,markdown,mkd setlocal spell
    "set hidden                      " allow buffer switching without saving


    set cryptmethod=blowfish2

    " Setting up the directories {
        set backup                      " backups are nice ...
        if has('persistent_undo')
            set undofile                "so is persistent undo ...
            set undolevels=1000         "maximum number of changes that can be undone
            set undoreload=10000        "maximum number lines to save for undo on a buffer reload
        endif

    " }
    "
    " setting up for diff mode {
        set diffopt-=horizontal
        set diffopt+=vertical
        if has('patch-8.1.0360')
            set diffopt+=internal,algorithm:patience
        endif
    " }

    " If you have vim >=8.0 or Neovim >= 0.1.5
    " if has('termguicolors')
     " set termguicolors
    " endif
" }
"
" File {
    "Setup bomb "保留bomb头a
    set nobomb "去掉bomb头
    let &termencoding=&encoding  "vim 在与屏幕/键盘交互使用的编码
    if has('win32') || has('win64')
        "set encoding=utf-8 will cause displaying invalid characters
        "fix it in windows
        "@see http://www.douban.com/note/145491549/
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        language message zh_CN.UTF-8
    endif
    set fileencoding=utf-8  "vim当前编辑的文件在存储时的编码
    set fileencodings=utf-8,gb2312,gbk,gb18030,big5   "vim 打开文件时的尝试使用的编码
    "set fileformat=unix,dos
    set fileformats=unix,dos
    set ambiwidth=double
"}

" Vim UI {
    set tabpagemax=1               " only show 1 tabs
    set showmode                    " display the current mode

    " those will mark screen redrawing slower, so set to disabled
    set nocursorline                  " highlight current line
    set nocursorcolumn
    " set colorcolumn=80,100,120  "显示right margin, 7.3+

    if has('cmdline_info')
        set ruler                   " show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
        set showcmd                 " show partial commands in status line and
                                    " selected characters/lines in visual mode
    endif

    if has('statusline')
        " Always show status line, even for one window
        set laststatus=2
        "The commandbar height
        " @see https://stackoverflow.com/questions/890802/how-do-i-disable-the-press-enter-or-type-command-to-continue-prompt-in-vim
        set cmdheight=2

        " Broken down into easily includeable segments
        set statusline=%<%f\    " Filename
        set statusline+=%w%h%m%r " Options
        "set statusline+=%{fugitive#statusline()} "  Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " filetype
        set statusline+=\ %{&fenc!=''?&fenc:&enc} "encoding
        "set statusline+=\ [%{getcwd()}]          " current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set relativenumber               " Relative number on
    "set nonumber
    "set norelativenumber
    "set showmatch                   " show matching brackets/parenthesis
    set noshowmatch
    set incsearch                   " find as you type search
    set hlsearch                    " highlight search terms
    set magic                       "显示括号配对情况
    "set winminheight=5              " windows can be 5 line high
    set ignorecase                  " case insensitive search
    "set noignorecase
    set smartcase                   " case sensitive when uc present
    "set nosmartcase
    set fileignorecase              " ignore case for file
    " set nofileignorecase           " do not ignore case for file
    set wildmenu                    " show list instead of just completing
    set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
    set scrolljump=5                " lines to scroll when cursor leaves screen
    set scrolloff=3                 " minimum lines to keep above and below cursor
    set lazyredraw                  " for performance

    " Do not use fold
    set nofoldenable

    "making folding enabled for the file that has more than 1000 lines
    function! SetFolding()
        let l:lines = line('$')
        "types that disable folding
        "help may be set as `text`
        let l:folding_disabled_types = ['text', 'help', 'javascript', 'objc', 'markdown', 'vim']
        let l:folding_start = 1000
        if l:lines < l:folding_start || index(l:folding_disabled_types, tolower(&filetype)) > -1
            setlocal nofoldenable
        else
            setlocal foldenable
            setlocal foldlevelstart=1
            setlocal foldmethod=indent
            setlocal foldnestmax=5
        endif
    endfunction
    " autocmd vimrc BufNewFile,BufRead * call SetFolding()

    set list
    set listchars=tab:\:\ ,trail:~,extends:>,precedes:<,nbsp:.
    set path=.,,,**                 " set path for find file


" }

" Formatting {
    "set nowrap                      " wrap long lines
    set wrap                         "折行显示

    " @see http://stackoverflow.com/questions/16840433/forcing-vimdiff-to-wrap-lines
    autocmd vimrc FilterWritePre * if &diff | setlocal wrap< | endif

    "set autoindent                  " indent at the same level of the previous line
    set cindent
    set shiftwidth=4                " use indents of 4 spaces
    set expandtab                   " tabs are spaces, not tabs
    set tabstop=4                   " an indentation every four columns
    set softtabstop=4               " let backspace delete indent
    set matchpairs+=<:>                " match, to be used with %
    set formatoptions+=mB              "break at a multi-byte character above 255, see https://groups.google.com/forum/#!topic/vim_use/HYy7sqje3bQ
    "set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    autocmd vimrc BufNewFile,BufRead,BufWritePre *.wiki setf wiki
" }

" Key (re)Mappings {

    "The default leader is '\', but many people prefer ',' as it's in a standard
    "location. To override this behavior and set it back to '\' (or any other
    "character) add let g:spf13_leader='\' in your .vimrc.bundles.local file
    "if !exists('g:spf13_leader')
    let g:mapleader = ','
    "else
        "let mapleader=g:spf13_leader
    "endif

    "
    "vim tips
    "@see http://www.vimbits.com/bits?sort=top
    "
    " Easier moving in tabs and windows
    "
    " <C-J> <C-K>   are keep for other plugins like UltiSnips
    "map <C-J> <C-W>j
    "map <C-K> <C-W>k
    map <C-L> <C-W>l
    map <C-H> <C-W>h

    " Wrapped lines goes down/up to next row, rather than next line in file.
    nnoremap j gj
    nnoremap k gk

    "format line easily
    nnoremap gq gqgq

    "clear search hilight
    "noremap <silent><Leader>/ :nohls<CR>
    nnoremap <silent> \ :nohls<CR>

    "use sane regular expresion
    "nnoremap / /\v
    "vnoremap / /\v

    " The following two lines conflict with moving to top and bottom of the
    " screen
    " If you prefer that functionality, add let g:spf13_no_fastTabs = 1 in
    " your .vimrc.bundles.local file

    "if !exists('g:spf13_no_fastTabs')
        "map <S-H> gT
        "map <S-L> gt
    "endif

    " Stupid shift key fixes
    "if !exists('g:spf13_no_keyfixes')
        "if has("user_commands")
            "command! -bang -nargs=* -complete=file E e<bang> <args>
            "command! -bang -nargs=* -complete=file W w<bang> <args>
            "command! -bang -nargs=* -complete=file Wq wq<bang> <args>
            "command! -bang -nargs=* -complete=file WQ wq<bang> <args>
            "command! -bang Wa wa<bang>
            "command! -bang WA wa<bang>
            "command! -bang Q q<bang>
            "command! -bang QA qa<bang>
            "command! -bang Qa qa<bang>
        "endif

        "cmap Tabe tabe
    "endif

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$




    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " map <Leader>ff to display all lines with keyword under cursor
    " and ask which one to jump to
    nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH
" }


" helper {
    "
    " @param {String} fileName
    " @param {Integer} limitTimes
    " @return {Object}
    function! FindFileUp(fileName, limitTimes)
        let l:tempDir = fnamemodify(getcwd(), ':p:h')
        let l:tempFile = ''
        let l:counter = 0
        let l:isExist = 0
        let l:result = {}

        while l:counter <= a:limitTimes
            let l:tempFile = l:tempDir . '/' . a:fileName
            let l:isExist = filereadable(l:tempFile)
            if l:isExist
                let l:result['file'] = l:tempFile
                let l:result['filename']= a:fileName
                let l:result['distance']  =  l:counter
                return l:result
            endif
            let l:tempDir = fnamemodify(l:tempDir, ':p:h:h')
            let l:counter = l:counter + 1
        endwhile

        return l:result
    endfunction

    " @param {List<String>} fileNames
    " @param {Integer} limitTimes
    " @return {String}
    function! FindFilesUp(fileNames, limitTimes)
        let l:minDistance = -1
        let l:closestItem = {}

        for l:item in a:fileNames
            let l:found = FindFileUp(l:item, a:limitTimes)
            let l:distance = get(l:found, 'distance', -1)
            if l:distance > -1
                if l:minDistance < 0
                    let l:minDistance = l:distance
                    let l:closestItem = l:found
                elseif l:minDistance > l:distance
                    let l:minDistance = l:distance
                    let l:closestItem = l:found
                endif
            endif
        endfor

        let l:theFile = get(l:closestItem, 'filename', '')
        return l:theFile
    endfunction

    " @return {2|2.7|3}
    function! DetectVueVersion()
        let found =  FindFileUp('package.json', 15)
        let file = get(found, 'file', '')
        let l:version = 2
        if empty(file)
            return l:version
        endif
        let lines = readfile(file)
        let content = join(lines, '')
        let data = json_decode(content)
        if empty(data)
            return l:version
        endif

        let dependencies = get(data, 'dependencies', {})
        let vue = get(dependencies, 'vue', '')

        if empty(vue)
            let dependencies = get(data, 'devDependencies', {})
            let vue = get(dependencies, 'vue', '')
        endif

        if empty(vue)
            return l:version
        endif

        " vue value may  '^3.x.y' or '3.x.y'
        if match(vue, '\^3\.') == 0 || match(vue, '3\.') == 0
            let l:version = 3
        endif

        if match(vue, '\^2\.7') == 0 || match(vue, '2\.7') == 0
            let l:version = 2.7
        endif

        return l:version
    endfunction

    let g:vimrc_vue_version = DetectVueVersion()
    let g:vimrc_performance_low = 1
" }

" Plugins {
    " ack.vim/ag.vim {
        " @see http://robots.thoughtbot.com/faster-grepping-in-vim
        "set grepprg=ack
        "
        if executable('rg')
            " @see https://github.com/BurntSushi/ripgrep/issues/425
            set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
            " @see https://www.philipbradley.net/posts/2017-03-29-ripgrep-with-ctrlp-and-vim/
            let g:ackprg = 'rg --vimgrep --hidden --no-heading --smart-case'
        elseif executable('ag')
            " The Silver Searcher
            set grepprg=ag\ --nogroup\ --nocolor\ --smart-case
            let g:ackprg = 'ag --vimgrep --hidden --smart-case'
        endif

    " }

    " ntpeters/vim-better-whitespace {
        " use :StripWhitespace manully
        " let g:strip_whitespace_on_save = 1
        " let g:strip_max_file_size = 1000
        " let g:better_whitespace_filetypes_blacklist=[
                    " \ 'diff',
                    " \ 'git',
                    " \ 'gitcommit',
                    " \ 'unite',
                    " \ 'qf',
                    " \ 'help',
                    " \'markdown',
                    " \ 'fugitive'
                    " \]
    "  }

    " autoHighlight.vim {
        let g:auto_highlight_enable = 0
    " }

    " superTab.vim {
        "let g:SuperTabDefaultCompletionType = "context"
        "let g:SuperTabLongestEnhanced = 1
     "}

     " FuDesign2008/vim-auto-save{
         let g:auto_save = 1
         let g:auto_save_write_all_buffers = 1
         let g:auto_save_silent = 1
     "}



        if count(g:spf13_autocomplete_method, 'vim-lsp')
         " asyncomplete.vim {
            "@see https://github.com/prabirshrestha/asyncomplete.vim#tab-completion
                inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
                inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
                inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

                " disable diagnostics, use ALE instead
                " let g:lsp_diagnostics_enabled=1
                let g:lsp_diagnostics_echo_cursor=1
                let g:lsp_diagnostics_virtual_text_enabled=0
                " let g:lsp_diagnostics_float_cursor=1
                let g:lsp_document_code_action_signs_enabled=1

                let g:asyncomplete_matchfuzzy=0
                let g:asyncomplete_max_num_candidates=15

                if exists('*matchfuzzypos') == 0
                    " Match items case-sensitive
                    " @see https://github.com/machakann/asyncomplete-ezfilter.vim
                    let g:asyncomplete#preprocessor#ezfilter#config = {}
                    let g:asyncomplete#preprocessor#ezfilter#config['*'] =  {ctx, items -> ctx.filter(items, 0)}
                    let g:asyncomplete_preprocessor =  [function('asyncomplete#preprocessor#ezfilter#filter')]
                endif


                " let g:UltiSnipsExpandTrigger="<c-e>"
                call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
                    \ 'name': 'ultisnips',
                    \ 'allowlist': ['*'],
                    \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
                    \ }))

                au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
                    \ 'name': 'file',
                    \ 'allowlist': ['*'],
                    \ 'completor': function('asyncomplete#sources#file#completor')
                    \ }))

                call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
                    \ 'name': 'buffer',
                    \ 'allowlist': ['*'],
                    \ 'blocklist': ['go', 'typescript', 'typescriptreact'],
                    \ 'completor': function('asyncomplete#sources#buffer#completor'),
                    \ 'config': {
                    \    'max_buffer_size': 5000,
                    \  },
                    \ }))

                " au User asyncomplete_setup call asyncomplete#register_source({
                    " \ 'name': 'look',
                    " \ 'allowlist': ['text', 'markdown'],
                    " \ 'completor': function('asyncomplete#sources#look#completor'),
                    " \ })


                autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
                    \ 'name': 'omni',
                    \ 'allowlist': ['*'],
                    \ 'blocklist': ['c', 'cpp', 'html', 'javascript', 'vue', 'typescript', 'typescriptreact'],
                    \ 'completor': function('asyncomplete#sources#omni#completor'),
                    \ 'config': {
                    \   'show_source_kind': 1,
                    \ },
                    \ }))

                " au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#emoji#get_source_options({
                    " \ 'name': 'emoji',
                    " \ 'allowlist': ['*'],
                    " \ 'completor': function('asyncomplete#sources#emoji#completor'),
                    " \ }))

            " }

            "vim-lsp.vim
                let g:lsp_ignorecase = 0
                let g:lsp_settings_filetype_vue = g:vimrc_vue_version == 3 || g:vimrc_vue_version == 2.7 ? ['volar-server'] : ['vls']
                let g:lsp_settings_root_markers = ['package.json', '.git', '.git/']
                let g:lsp_settings = {
                    \  'typescript-language-server': {
                    \    'disabled': 0,
                    \   }
                    \}
            "}
        endif

        if count(g:spf13_autocomplete_method, 'deoplete')
            " Shougo/deoplete.nvim {
                let g:deoplete#enable_at_startup = 1
                call deoplete#custom#option({
                \ 'auto_complete_delay': 200,
                \ 'smart_case': v:true,
                \ 'candidate_marks': ['A', 'S', 'D', 'F', 'G'],
                \ })
                inoremap <expr>A       pumvisible() ?  deoplete#insert_candidate(0) : 'A'
                inoremap <expr>S       pumvisible() ?  deoplete#insert_candidate(1) : 'S'
                inoremap <expr>D       pumvisible() ?  deoplete#insert_candidate(2) : 'D'
                inoremap <expr>F       pumvisible() ?  deoplete#insert_candidate(3) : 'F'
                inoremap <expr>G       pumvisible() ?  deoplete#insert_candidate(4) : 'G'
            " }
            "
            " Shougo/echodoc.vim {
                " To use echodoc, you must increase 'cmdheight' value.
                set cmdheight=2
                let g:echodoc_enable_at_startup = 1
            " }

            " carlitux/deoplete-ternjs {
                let g:deoplete#sources#ternjs#types = 1
                let g:deoplete#sources#ternjs#depths = 1
                let g:deoplete#sources#ternjs#docs = 1
                let g:deoplete#sources#ternjs#include_keywords = 1
                let g:deoplete#sources#ternjs#filetypes = [
                            \ 'jsx',
                            \ 'javascript.jsx',
                            \ ]
            " }

        endif

        if count(g:spf13_autocomplete_method, 'coc')
             " coc.nvim {
                    " Some servers have issues with backup files, see #649
                    set nobackup
                    set nowritebackup
                    " Better display for messages
                    set cmdheight=2
                    " You will have bad experience for diagnostic messages when it's default 4000.
                    set updatetime=300
                    " don't give |ins-completion-menu| messages.
                    set shortmess+=c
                    " always show signcolumns
                    set signcolumn=yes

                    " Use tab for trigger completion with characters ahead and navigate.
                    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
                    inoremap <silent><expr> <TAB>
                          \ pumvisible() ? "\<C-n>" :
                          \ <SID>check_back_space() ? "\<TAB>" :
                          \ coc#refresh()
                    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

                    function! s:check_back_space() abort
                      let col = col('.') - 1
                      return !col || getline('.')[col - 1]  =~# '\s'
                    endfunction

                    " Use <c-space> to trigger completion.
                    " inoremap <silent><expr> <c-space> coc#refresh()

                    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
                    " Coc only does snippet and additional edit on confirm.
                    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

                    " Use `<c-s-k>` and `<c-s-j>` to navigate diagnostics
                    " ⚠️  same-like shortcut with ALE
                    nmap <silent> <C-S-k> <Plug>(coc-diagnostic-prev)
                    nmap <silent> <C-S-j> <Plug>(coc-diagnostic-next)

                    " Remap keys for gotos
                    " ⚠️  same shortcut with ALE
                    nmap <silent> <leader>d <Plug>(coc-definition)
                    nmap <silent> <leader>td <Plug>(coc-type-definition)
                    nmap <silent> <leader>i <Plug>(coc-implementation)
                    nmap <silent> <leader>rf <Plug>(coc-references)

                    " Use K to show documentation in preview window
                    " ⚠️  same shortcut with YCMHover
                    nnoremap <silent> K :call <SID>show_documentation()<CR>

                    function! s:show_documentation()
                      if (index(['vim','help'], &filetype) >= 0)
                        execute 'h '.expand('<cword>')
                      else
                        call CocAction('doHover')
                      endif
                    endfunction

                    " Highlight symbol under cursor on CursorHold
                    " autocmd vimrc CursorHold * silent call CocActionAsync('highlight')

                    " Remap for rename current word
                    nmap <leader>r <Plug>(coc-rename)

                    " Remap for format selected region
                    " xmap <leader>f  <Plug>(coc-format-selected)
                    " nmap <leader>f  <Plug>(coc-format-selected)

                    " augroup mygroup
                      " autocmd!
                      " Setup formatexpr specified filetype(s).
                      " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
                      " Update signature help on jump placeholder
                      " autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
                    " augroup end

                    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
                    " xmap <leader>a  <Plug>(coc-codeaction-selected)
                    " nmap <leader>a  <Plug>(coc-codeaction-selected)

                    " Remap for do codeAction of current line
                    " nmap <leader>ac  <Plug>(coc-codeaction)
                    " Fix autofix problem of current line
                    nmap <leader>f  <Plug>(coc-fix-current)

                    " Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
                    " nmap <silent> <TAB> <Plug>(coc-range-select)
                    " xmap <silent> <TAB> <Plug>(coc-range-select)
                    " xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

                    " Use `:Format` to format current buffer
                    " command! -nargs=0 Format :call CocAction('format')

                    " Use `:Fold` to fold current buffer
                    " command! -nargs=? Fold :call     CocAction('fold', <f-args>)

                    " use `:ImportOrganize` for organize import of current buffer
                    command! -nargs=0 ImportOrganize   :call     CocAction('runCommand', 'editor.action.organizeImport')

                    " Add status line support, for integration with other plugin, checkout `:h coc-status`
                    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

                    " Using CocList
                    " Show all diagnostics
                    " nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
                    " Manage extensions
                    " nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
                    " Show commands
                    " nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
                    " Find symbol of current document
                    " nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
                    " Search workspace symbols
                    " nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
                    " Do default action for next item.
                    " nnoremap <silent> <space>j  :<C-u>CocNext<CR>
                    " Do default action for previous item.
                    " nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
                    " Resume latest coc list
                    " nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
             " }
             " neoclide/coc-snippets {
                    " inoremap <silent><expr> <TAB>
                          " \ pumvisible() ? coc#_select_confirm() :
                          " \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
                          " \ <SID>check_back_space() ? "\<TAB>" :
                          " \ coc#refresh()

                    " function! s:check_back_space() abort
                      " let col = col('.') - 1
                      " return !col || getline('.')[col - 1]  =~# '\s'
                    " endfunction

                    " let g:coc_snippet_next = '<tab>'
             " }

                " vim-language-server {
                let g:markdown_fenced_languages = [
                    \ 'vim',
                    \ 'help'
                    \]
                " }
                " call coc#add_extension(
                    " \'coc-vimlsp',
                    " \'coc-sources',
                    " \'coc-tsserver',
                    " \'coc-json',
                    " \'coc-html',
                    " \'coc-css',
                    " \'coc-svg',
                    " \'coc-vetur',
                    " \'coc-python',
                    " \'coc-git',
                    " \'coc-snippets'
                    " \)

        endif

        if count(g:spf13_autocomplete_method, 'ycm')
             " YCM.vim {
                " the default .ycm_extra_conf.py
                let g:ycm_global_ycm_extra_conf = expand('~/.ycm_extra_conf.py')
                let g:ycm_confirm_extra_conf = 0
                let g:ycm_complete_in_comments = 1
                let g:ycm_collect_identifiers_from_comments_and_strings = 1
                let g:ycm_collect_identifiers_from_tags_files = 1
                let g:ycm_seed_identifiers_with_syntax = 1
                let g:ycm_min_num_of_chars_for_completion = g:vimrc_performance_low ? 3 :  2
                let g:ycm_min_num_identifier_candidate_chars = g:vimrc_performance_low ? 3 : 2
                let g:ycm_always_populate_location_list = 0

                let g:ycm_add_preview_to_completeopt = 0
                let g:ycm_autoclose_preview_window_after_insertion = 0

                let g:ycm_lsp_examples_vimrc = expand('~/.vim/bundle/lsp-examples/vimrc.generated')
                if filereadable(g:ycm_lsp_examples_vimrc)
                    execute 'source ' . g:ycm_lsp_examples_vimrc
                endif
                unlet g:ycm_lsp_examples_vimrc

                set completeopt="menu,popup"
                if g:vimrc_performance_low
                    set updatetime=4000
                else
                    set updatetime=3000
                endif

                " prefer to use shortcut
                let g:ycm_auto_hover = ''
                " let g:ycm_auto_hover = 'CursorHold'

                " ⚠️  same shortcut with show_documentation of coc
                nnoremap K <plug>(YCMHover)
                " augroup MyYCMCustom
                    " autocmd!
                    " autocmd FileType typescript,javascript let b:ycm_hover = {
                      " \ 'command': 'GetType',
                      " \ 'syntax': &filetype
                      " \ }
                " augroup END


                " default
                "let g:ycm_key_list_select_completion = ['<TAB>', '<DOWN>'] " with vim default: <c-n>
                "let g:ycm_key_list_previous_completion = ['<S-TAB>', '<UP>'] " with vim default: <c-p>
                let g:ycm_key_invoke_completion = '<C-S-N>'


                "the default setting
                      "\ 'markdown' : 1,
                let g:ycm_filetype_blacklist = {
                      \ 'tagbar' : 1,
                      \ 'qf' : 1,
                      \ 'notes' : 1,
                      \ 'unite' : 1,
                      \ 'text' : 1,
                      \ 'vimwiki' : 1,
                      \ 'pandoc' : 1,
                      \ 'infolog' : 1,
                      \ 'mail' : 1,
                      \ 'vue' : 1
                      \}

                if !exists('g:ycm_semantic_triggers')
                    " default
                    let g:ycm_semantic_triggers = {
                            \   'c': ['->', '.'],
                            \   'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
                            \            're!\[.*\]\s'],
                            \   'ocaml': ['.', '#'],
                            \   'cpp,cuda,objcpp': ['->', '.', '::'],
                            \   'perl': ['->'],
                            \   'php': ['->', '::'],
                            \   'cs,d,elixir,go,groovy,java,javascript,julia,perl6,python,scala,typescript,vb': ['.'],
                            \   'ruby,rust': ['.', '::'],
                            \   'lua': ['.', ':'],
                            \   'erlang': [':'],
                            \ }
                endif

                " let g:ycm_semantic_triggers['javascript'] = ['.', '__']
                " let g:ycm_semantic_triggers['typescript'] = ['.', '__']

                " for css @see https://github.com/Valloric/YouCompleteMe/issues/413
                " : for property: value
                " - for properties like border-radius
                " . for collect class name from html/vue file
                "
                " BUT the following config will disable UltiSnips in .css/.scss/.less
                " file
                "
                " let g:ycm_semantic_triggers['css'] = [ 're!^', 're!^\s+', ': ', '-' , '.' ]
                " let g:ycm_semantic_triggers['scss'] = [ 're!^', 're!^\s+', ': ', '-', '.' ]
                " let g:ycm_semantic_triggers['less'] = [ 're!^', 're!^\s+', ': ', '-', '.' ]
             "}
        endif



     "ultisnips {
        let g:UltiSnipsExpandTrigger='<c-j>'
        " default
        "let g:UltiSnipsListSnippets='<c-tab>'
        "let g:UltiSnipsJumpForwardTrigger='<c-j>'
        "let g:UltiSnipsJumpBackwardTrigger='<c-k>'
     "}
     "
     " vim-javacomplete2 {
        " autocmd vimrc FileType java set omnifunc=javacomplete#Complete
     " }


     " js-complete.vim {
         "autocmd vimrc FileType javascript  :setl omnifunc=jscomplete#CompleteJS
     "}

    " AutoClose.vim {
        "let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'", '`': '`'}
    " }

    " FuDesign2008/plan.vim {
    "
        function! ConfigPlanPlugin()
            if g:is_win
                let philosophyDir = 'E:\workspace\github2008\philosophy'
            else
                let philosophyDir = '~/workspace/github2008/philosophy'
            endif
            let g:p_edit_files = {
                \ 'profession': expand(philosophyDir . '/profession'),
                \ 'patents': expand(philosophyDir . '/profession/patents'),
                \ 'interview': expand(philosophyDir . '/profession/interview'),
                \ 'small-family': expand(philosophyDir . '/small-family'),
                \ 'pwd': expand(philosophyDir . '/pwd'),
                \ 'log': expand(philosophyDir . '/log'),
                \ 'vlog': expand(philosophyDir . '/investing/log'),
                \ 'philosophy': expand(philosophyDir)
                \}


            let l:cur_year = strftime('%Y')
            "01-12
            let l:cur_month = strftime('%m')
            let l:cur_month = l:cur_year . '-' . l:cur_month

            let l:plan_year_path =  expand(philosophyDir . '/plan/' . l:cur_year)
            let l:plan_file_pattern = expand(l:plan_year_path .'/' . l:cur_month . '/plan') . '.*'

            "  ~/workspace/github2008/philosophy/plan/2013/2013-04/2013-04.*
            "  the plan file may has different file extension
            let l:plan_file_pattern_old = expand(l:plan_year_path .'/' . l:cur_month . '/' . l:cur_month) . '.*'
            let l:diary_file_pattern = expand(l:plan_year_path .'/' . l:cur_month . '/diary') . '*'
            let l:team_work_file_path = expand(l:plan_year_path .'/' . l:cur_month . '/team-work.md')
            let g:p_edit_files['teamwork'] = l:team_work_file_path

            "
            let l:fileList = glob(l:plan_file_pattern, 0, 1)
            let l:plan_file_path = get(l:fileList, 0, '')
            if strlen(l:plan_file_path) > 0
                let g:p_edit_files['plan'] = l:plan_file_path
            else
                let l:fileList = glob(l:plan_file_pattern_old, 0, 1)
                let l:plan_file_path = get(l:fileList, 0, '')
                if strlen(l:plan_file_path) > 0
                    let g:p_edit_files['plan'] = l:plan_file_path
                else
                    let g:p_edit_files['plan'] = l:plan_year_path
                endif
            endif

            let l:fileList = glob(l:diary_file_pattern, 0, 1)
            let l:diary_file_path = get(l:fileList, 0, '')
            if strlen(l:diary_file_path) > 0
                let g:p_edit_files['diary'] = l:diary_file_path
            else
                let g:p_edit_files['diary'] = l:plan_year_path
            endif

            " regular task

            let g:plan_week_keypoint = []

            "0 = sunday
            "1 = monday
            "...
            "6 = sat
                " \ 2 : '1. 工作周报;'
            let g:plan_week_work = {
                \ 1 : '1. 电脑移除与升级软件;'
                \}
            let g:plan_week_personal = {
                \ 0 : '1. 断舍离;   - 清理手机;    - 清理家庭居所;'
                \}

            let g:plan_week_review = []

            let g:plan_month_keypoint = []

            let g:plan_month_work = {}
            let g:plan_month_personal = {
                \ 5 : '1. 查询薪水发放;1. 孩子培养基金;1. 工行房贷(10);1. 天津农行房贷(06);'
                \}

            let g:plan_month_review = [
                \ '1. 家庭财产统计;'
                \]

                " \ '01-01': '1. 修改密-码: corp 邮箱, rd邮箱, wifi网络;',
                " \ '05-01': '1. 修改密-码: corp 邮箱, rd邮箱, wifi网络;',
                " \ '09-01': '1. 修改密-码: corp 邮箱, rd邮箱, wifi网络;',
            let g:plan_year_personal = {
                \ '02-25': '1. 检查住房公积金提取;',
                \ '05-25': '1. 检查住房公积金提取;',
                \ '06-24': '1. 半年回顾与规划;',
                \ '06-30': '1. 🎂生日快乐;',
                \ '08-25': '1. 检查住房公积金提取;',
                \ '09-12': '1. 纪念日;',
                \ '11-25': '1. 检查住房公积金提取;',
                \ '12-24': '1. 半年回顾与规划;',
                \ '12-30': '1. 结婚纪念日;'
                \}

            unlet philosophyDir

        endfunction

        call ConfigPlanPlugin()

    "}

    " FuDesign2008/webSearch.vim {
        let g:webSearchEngines = {
            \ 'google': 'https://www.google.com.hk/search?hl=en&q=<QUERY>',
            \ 'github': 'https://github.com/search?q=<QUERY>',
            \ 'mozilla': 'https://developer.mozilla.org/en-US/search?q=<QUERY>',
            \}
    " }
    "
    "easymotion.vim{
        "let g:EasyMotion_leader_key = '<Leader>'
    "}


    " FuDesign2008/randomTheme.vim {
        " @see https://forum.ubuntu.com.cn/viewtopic.php?t=45358
        " @see :help setting-guifont
        function! SetGuiFont(font, size)
            if has('gui_running')
                " for ubuntu vim-gonme
                if has('x11')
                    let commandStr = 'set guifont=' . a:font . '\ ' . a:size
                    execute commandStr
                else
                    let commandStr = 'set guifont='. a:font . ':h' . a:size
                    execute commandStr
                endif
            endif
        endfunction

        let g:gui_font_size = '12'

        if has('gui_running')
            if has('x11')
                " for linux + 2k display
                let g:gui_font_size = '10'
            elseif has('macunix')
                if system('arch') ==? 'arm64'
                    " for m1 macbook air
                    let g:gui_font_size = '14'
                else
                    let g:gui_font_size = '14'
                endif
            elseif g:is_win
                let g:gui_font_size = '10'
            endif
        endif


                    " \ 'Monaco:h14'
                    " \ 'cascadia\ code:h' . g:gui_font_size,
                    " \ 'fira\ code:h' . (g:gui_font_size)
                    " \ 'inconsolata:h'. (g:gui_font_size + 2)
        let g:favorite_gui_fonts = [
                    \ 'source\ code\ pro:h'. (g:gui_font_size),
                    \ 'ibm\ plex\ mono:h'. (g:gui_font_size),
                    \ 'roboto\ mono:h' . g:gui_font_size,
                    \ 'intelone\ mono:h' . g:gui_font_size,
                    \ 'hack:h'. (g:gui_font_size)
                    \]


        let g:random_theme_start = 'all:light'

    " }

    " FuDesign2008/openUrl.vim {

        " the url prefix for jira issue item
        let g:open_jira_prefix='http://jira.corp.youdao.com/browse/'

    " }



    " pangloss/vim-javascript {
        let g:javascript_enable_domhtmlcss = 1

        let g:javascript_conceal_function   = 'ƒ'
        let g:javascript_conceal_null       = 'ø'
        let g:javascript_conceal_this       = '@'
        let g:javascript_conceal_return     = '⇚'
        let g:javascript_conceal_undefined  = '¿'
        let g:javascript_conceal_NaN        = 'ℕ'
        let g:javascript_conceal_prototype  = '¶'
        let g:javascript_conceal_static     = '•'
        let g:javascript_conceal_super      = 'Ω'
    " }

    " tern_for_vim {
        let g:tern_show_argument_hints = 'on_hold'
        let g:tern_map_keys = 1

    " }

    " vim-jsdoc {
    " }

    " NERDCommenter {
        let g:NERDCustomDelimiters = {
            \ 'python' : { 'left': '#'}
            \}
        let g:NERDSpaceDelims = 1

    " }

    " Raimondi/delimitMate {
        let g:delimitMate_expand_cr = 2
        let g:delimitMate_expand_space = 1
        let g:delimitMate_balance_matchpairs = 1
    "}

    " junegunn/rainbow_parentheses.vim {
        " autocmd vimrc FileType typescript,javacript,css,scss RainbowParentheses
    "}

    " coffeescript plugin {
        " http://www.vim.org/scripts/script.php?script_id=3590
        autocmd vimrc BufRead,BufNewFile,BufWritePre *.coffee setf coffee
    "}

    " typescript plugin {
        autocmd vimrc BufRead,BufNewFile,BufWritePre *.ts setf typescript
    " }

    "react support {
        " autocmd vimrc BufRead,BufNewFile,BufWritePre *.tsx setf typescript
        " autocmd vimrc BufRead,BufNewFile,BufWritePre *.jsx setf javascript
    "}


    "less.vim {
        autocmd vimrc BufRead,BufNewFile,BufWritePre *.less setf less
    "}

    "calendar {
        "let g:calendar_mark = 'right'
    "}

    "zoom.vim {

    "}

    "ZoomWin {
        nnoremap <C-W>z <Plug>ZoomWin
    "}

    " support https://github.com/davidtheclark/cosmiconfig
    " try to find eslint first and then jshint in the same directory
    let g:find_file_name = FindFilesUp([
        \ '.eslintrc',
        \ '.eslintrc.json',
        \ '.eslintrc.js',
        \ '.eslintrc.yaml',
        \ '.eslintrc.yml',
        \ '.jshintrc',
        \ '.jshintrc.json',
        \ '.jshintrc.js',
        \ '.jshintrc.yaml',
        \ '.jshintrc.yml',
        \ '.flowconfig',
        \ ], 10)
    let g:use_jshint_for_javascript = stridx(g:find_file_name, 'jshintrc') > -1
    let g:use_eslint = stridx(g:find_file_name, 'eslintrc') > -1
    let g:use_flow_for_javascript = stridx(g:find_file_name, 'flowconfig') > -1

    let g:find_file_name = FindFilesUp([
        \ 'tslint.json',
        \ 'tslint.yaml',
        \ '.eslintrc',
        \ '.eslintrc.json',
        \ '.eslintrc.js',
        \ '.eslintrc.yaml',
        \ '.eslintrc.yml'
        \ ], 10)
    let g:use_tslint_for_typescript = stridx(g:find_file_name, 'tslint') > -1

    let g:find_file_name = FindFilesUp([
        \ '.stylelintrc',
        \ '.stylelintrc.json',
        \ '.stylelintrc.js',
        \ '.stylelintrc.yaml',
        \ '.stylelintrc.yml'
        \], 10)
    let g:use_stylelint_for_style = stridx(g:find_file_name, 'stylelintrc') > -1

    unlet g:find_file_name

    "Syntastic {
        " the recommend setting form README
        " set statusline+=%#warningmsg#
        " set statusline+=%{SyntasticStatuslineFlag()}
        " set statusline+=%*

        function! SyntasticCheckHook(errors)
            if !empty(a:errors)
                let g:syntastic_loc_list_height = min([len(a:errors), 3])
            endif
        endfunction

        if &diff
            let g:syntastic_always_populate_loc_list = 0
            let g:syntastic_auto_loc_list = 0
            let g:syntastic_check_on_open = 0
        else
            let g:syntastic_always_populate_loc_list = 1
            let g:syntastic_auto_loc_list = 1
            let g:syntastic_check_on_open = 1
        endif


        let g:syntastic_check_on_wq = 1

        let g:syntastic_objc_compiler = 'clang'
        let g:syntastic_php_checkers = ['phpmd']
        let g:syntastic_vim_checkers = ['vint']

        let g:syntastic_java_checkers = ['javac', 'checkstyle']
        let g:syntastic_java_javac_config_file_enabled = 1

        let g:find_file_path = get(
            \ FindFileUp('.syntastic_javac_config', 10),
            \ 'file',
            \ ''
            \ )

        if strlen(g:find_file_path) > 1
            let g:syntastic_java_javac_config_file = g:find_file_path
        endif

        if g:use_jshint_for_javascript
            let g:syntastic_javascript_checkers = ['jshint', 'tern-lint']
        else
            let g:syntastic_javascript_checkers = ['eslint', 'tern-lint']
            let g:syntastic_javascript_eslint_exec = 'eslint_d'
        endif
        unlet g:find_file_path

        let g:syntastic_typescript_checkers = ['tslint']
        let g:syntastic_vue_checkers = ['eslint']

        let g:syntastic_mode_map = {
                    \ 'mode': 'passive',
                    \ 'active_filetypes': [
                        \ 'css',
                        \ 'html',
                        \ 'javascript',
                        \ 'typescript',
                        \ 'json',
                        \ 'less',
                        \ 'markdown',
                        \ 'php',
                        \ 'python',
                        \ 'sh',
                        \ 'vim',
                        \ 'xhtml',
                        \ 'xml',
                        \ 'zsh'
                    \],
                    \ 'passive_filetypes': [
                        \ 'c',
                        \ 'cpp',
                        \ 'java'
                    \]
                \}

    "}


    " ALE {

        if &diff
            let g:ale_enabled = 0
        else
            nmap <silent> <C-k> <Plug>(ale_previous_wrap)
            nmap <silent> <C-j> <Plug>(ale_next_wrap)


            let g:ale_linter_aliases = {
                        \ 'vue': ['vue', 'html', 'javascript', 'typescript', 'css', 'scss']
                        \ }
            " linters do not use lsp server
            " ycm/vim-lsp ... support lsp
            let g:ale_linters = {
                        \ 'markdown': ['remark-lint', 'markdownlint'],
                        \ 'json': ['jsonlint'],
                        \ 'jsonc': ['eslint'],
                        \ 'javascript': ['eslint'],
                        \ 'typescript': ['eslint'],
                        \ 'typescriptreact': ['eslint'],
                        \ 'vue': ['stylelint', 'eslint'],
                        \ 'shell': ['shellcheck', 'language_server'],
                        \ 'c': [],
                        \ 'cpp': [],
                        \ 'java': ['javac', 'checkstyle'],
                        \ 'yaml': ['yamllint', 'prettier'],
                        \ 'dockerfile': ['hadolint'],
                        \ 'tex': []
                        \ }

            " *.vue do not use vls or volar for use of vim-lsp

            " let g:ale_vue_vls_use_global = 1
            " let g:ale_vue_volar_use_global = 1
            " let g:ale_vue_volar_executable = 'vue-language-server'
            " if g:vimrc_vue_version == 3 || g:vimrc_vue_version == 2.7
                " let g:ale_linters['vue'] = ['stylelint', 'volar', 'eslint']
            " endif

            let g:ale_disable_lsp = 1

            if count(g:spf13_autocomplete_method, 'vim-lsp')
                nnoremap <silent> <leader>d <plug>(lsp-definition)
                " nnoremap <silent> <leader>p <plug>(lsp-peek-definition)
                nnoremap <silent> <leader>r <plug>(lsp-rename)
                nnoremap <silent> <leader>td <plug>(lsp-type-definition)
                nnoremap <silent> K <plug>(lsp-hover)
            endif

            if g:ale_disable_lsp == 0
                nmap <silent> <leader>d :ALEGoToDefinition <CR>
                nmap <silent> <leader>td :ALEGoToTypeDefinition <CR>
                nmap <silent> <leader>r :ALERename <CR>
            endif

            nmap <leader>f   :ALEFix <CR>

            let g:ale_sign_column_always = 1
            " Prefer to use shortcut
            " Do not show window for more space
            let g:ale_open_list = 0
            let g:ale_keep_list_window_open = 0
            let g:ale_list_window_size = 3

            let g:ale_sign_error = '✗'
            let g:ale_sign_warning = '!'

            let g:ale_lint_on_enter=1
            let g:ale_lint_on_filetype_changed=1

            if g:vimrc_performance_low
                let g:ale_lint_on_text_changed = 0
                let g:ale_lint_on_insert_leave = 0
                let g:ale_lint_on_save=1
                let g:ale_lint_delay=400
            else
                let g:ale_lint_on_text_changed = 1
                let g:ale_lint_on_insert_leave = 1
                let g:ale_lint_on_save=1
                let g:ale_lint_delay=200
            endif

            let g:ale_completion_max_suggestions = 5
            let g:ale_max_signs = 5
            let g:ale_maximum_file_size = 1024 * 1024
            let g:ale_cache_executable_check_failures = 1
            " Do not lint or fix minified files.
            let g:ale_pattern_options = {
                \ '\.min\.js$': {'ale_enabled': 0},
                \ '\.min\.css$': {'ale_enabled': 0},
                \ 'dist\/': {'ale_enabled': 0}
                \ }

            let g:ale_fix_on_save = stridx(getcwd(), 'glodon') == -1 ? 1 : 0
            let g:ale_javascript_prettier_use_local_config = 1
            let g:ale_fixers = {
                        \ 'markdown': ['prettier'],
                        \ 'html': ['prettier'],
                        \ 'json': ['prettier', 'fixjson'],
                        \ 'jsonc': ['prettier'],
                        \ 'css': ['prettier'],
                        \ 'less': ['prettier'],
                        \ 'scss': ['prettier'],
                        \ 'javascript': ['prettier'],
                        \ 'typescript': ['prettier'],
                        \ 'typescriptreact': ['prettier'],
                        \ 'vue': ['prettier'],
                        \ 'yaml': ['yamlfix', 'prettier'],
                        \ 'c': ['clang-format']
                        \}

            if g:use_stylelint_for_style
                let g:ale_fixers['css'] = ['stylelint', 'prettier']
                let g:ale_fixers['less'] = ['stylelint', 'prettier']
                let g:ale_fixers['scss'] = ['stylelint', 'prettier']
            endif

            if g:use_jshint_for_javascript
                let g:ale_linters['javascript'] = ['jshint', 'tsserver']
                let g:ale_fixers['javascript'] = ['prettier']
            elseif g:use_eslint
                let g:ale_fixers['javascript'] = ['eslint', 'prettier']
                let g:ale_fixers['vue'] = ['eslint', 'prettier']
            elseif g:use_flow_for_javascript
                let g:ale_linters['javascript'] = ['flow']
                let g:ale_fixers['javascript'] = ['eslint', 'prettier']
            endif

            if g:use_tslint_for_typescript
                let g:ale_linters['typescript'] = ['tslint']
                let g:ale_fixers['typescript'] = ['prettier']

                let g:ale_linters['typescriptreact'] = ['tslint']
                let g:ale_fixers['typescriptreact'] = ['tslint', 'prettier']

                " enable tslint to lint .js file
                " @see
                " https://github.com/dense-analysis/ale/issues/1609
                " https://github.com/dense-analysis/ale#5xii-how-can-i-check-jsx-files-with-both-stylelint-and-eslint
                " augroup JSFiletypeGroup
                    " autocmd!
                    " au BufNewFile,BufRead,BufWritePre *.js set filetype=javascript.typescript
                " augroup END
            elseif g:use_eslint
                let g:ale_fixers['typescript'] = ['eslint', 'prettier']
                let g:ale_fixers['typescriptreact'] = ['eslint', 'prettier']
            endif

        endif

    " }
    " vim-scripts/LanguageTool {
        let g:languagetool_jar=expand('~/workspace/LanguageTool-4.6/languagetool-commandline.jar')

    " }

    " PIV {
        "let g:DisableAutoPHPFolding = 0
        "let g:PIVAutoClose = 0
    " }

    " Misc  {
        "let g:NERDShutUp=1
        "let b:match_ignorecase = 1
        "MarkdownViewer.vim
        let g:mdv_config_pack = {
            \  'github': {
                    \ 'theme': 'github2',
                    \ 'highlight_code': 1,
                    \ 'code_theme': 'default',
                    \ 'mermaid_img': 0
                \},
            \  'weixin': {
                    \ 'theme': 'github2',
                    \ 'highlight_code': 1,
                    \ 'code_theme': 'default',
                    \ 'mermaid_img': 1
                \},
            \ 'vue': {
                    \ 'theme': 'vue',
                    \ 'highlight_code': 1,
                    \ 'code_theme': 'default',
                    \ 'mermaid_img': 0
                \}
            \ }


    " }

    " plasticboy/vim-markdown {
        let g:vim_markdown_folding_disabled = 1
    "}


    "easytags {
        let g:easytags_async = 1
        let g:easytags_syntax_keyword = 'always'

        set tags=./.tags;,~/.vimtags
        set cpoptions=aAceFsBd
        let g:easytags_dynamic_files = 2

        " @see https://github.com/xolox/vim-easytags/issues/131
        " @see :help YCM
        let g:easytags_opts = ['--fields=+l']

        " let g:easytags_languages = {
        " \   'javascript': {
        " \     'cmd': 'jsctags',
        " \       'args': [],
        " \       'fileoutput_opt': '-f',
        " \       'stdout_opt': '-f-',
        " \       'recurse_flag': '-R'
        " \   }
        " \}


    "}

    " tagbar {
        "let g:tagbar_ctags_bin = "/usr/local/Cellar/ctags/5.8/bin/ctags"
        "let g:tagbar_type_javascript = {
            "\ 'ctagsbin' : '~/workspace/github/tools/doctorjs/bin'
        "\ }
        let g:tagbar_sort = 0
        let g:tagbar_compact = 0
        let g:tagbar_show_visibility = 1
        let g:tagbar_expand = 1
        let g:tagbar_left = 1
        let g:tagbar_show_linenumbers = 2
        let g:tagbar_iconchars = ['▸', '▾']

        function! OpenTagbarIfAvailable()
            if exists(':Tagbar')
                call tagbar#autoopen(1)
            endif
        endfunction

        autocmd vimrc VimEnter * nested :call OpenTagbarIfAvailable()

        " from https://github.com/jszakmeister/markdown2ctags
        " Add support for markdown files in tagbar.
        let g:tagbar_type_markdown = {
            \ 'ctagstype': 'markdown',
            \ 'ctagsbin' : expand('~/.vim/bundle/markdown2ctags/markdown2ctags.py'),
            \ 'ctagsargs' : '-f - --sort=yes',
            \ 'kinds' : [
                \ 's:sections',
                \ 'i:images'
            \ ],
            \ 'sro' : '|',
            \ 'kind2scope' : {
                \ 's' : 'section',
            \ },
            \ 'sort': 0,
        \ }

        " add a definition for Objective-C to tagbar
        let g:tagbar_type_objc = {
            \ 'ctagstype' : 'ObjectiveC',
            \ 'kinds'     : [
                \ 'i:interface',
                \ 'I:implementation',
                \ 'p:Protocol',
                \ 'm:Object_method',
                \ 'c:Class_method',
                \ 'v:Global_variable',
                \ 'F:Object field',
                \ 'f:function',
                \ 'p:property',
                \ 't:type_alias',
                \ 's:type_structure',
                \ 'e:enumeration',
                \ 'M:preprocessor_macro',
            \ ],
            \ 'sro'        : ' ',
            \ 'kind2scope' : {
                \ 'i' : 'interface',
                \ 'I' : 'implementation',
                \ 'p' : 'Protocol',
                \ 's' : 'type_structure',
                \ 'e' : 'enumeration'
            \ },
            \ 'scope2kind' : {
                \ 'interface'      : 'i',
                \ 'implementation' : 'I',
                \ 'Protocol'       : 'p',
                \ 'type_structure' : 's',
                \ 'enumeration'    : 'e'
            \ }
        \ }
    " }

    " AutoCloseTag {
        " Make it so AutoCloseTag works for xml and xhtml files as well
        autocmd vimrc FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
        nnoremap <Leader>ac <Plug>ToggleAutoCloseMappings
    " }


    " NerdTree {
        nnoremap <leader>tt :NERDTreeToggle <CR>
        let g:NERDTreeWinPos='right' "NerdTree窗口显示在右边
        "map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
        "map <leader>e :NERDTreeFind<CR>
        "nmap <leader>nt :NERDTreeFind<CR>

        "let NERDTreeShowBookmarks=1
        let g:NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        "let NERDTreeChDirMode=0
        "let NERDTreeQuitOnOpen=1
        "let NERDTreeMouseMode=2
        let g:NERDTreeShowHidden=1
        "let NERDTreeKeepTreeInNewTab=1
        "let g:nerdtree_tabs_open_on_gui_startup=0
    " }

    " Tabularize {
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
     " }

     "Matchmaker{
         let g:matchmaker_enable_startup = 1
     "}

     " Session List {
        "set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        "nmap <leader>sl :SessionList<CR>
        "nmap <leader>ss :SessionSave<CR>
     " }

     " Buffer explorer {
        "nmap <leader>b :BufExplorer<CR>
     " }

     " JSON {
        autocmd vimrc BufNewFile,BufRead,BufWritePre .jshintrc setf json
        autocmd vimrc BufNewFile,BufRead,BufWritePre .eslintrc setf json
        "nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
     " }

     " jsonc {
        " autocmd vimrc FileType json syntax match Comment +\/\/.\+$+
     " }

     " PyMode {
        "let g:pymode_lint_checker = "pyflakes"
        "let g:pymode_utils_whitespaces = 0
     " }



     " fzf.vim {

        if count(g:spf13_bundle_groups, 'fzf')
            let g:fzf_folder_via_git = fnamemodify('~/.fzf', ':p')
            " diable preview window for performance
            let g:fzf_preview_window = []
            let g:fzf_in_scoop=expand('~/scoop/apps/fzf/current')

            if isdirectory('/usr/local/opt/fzf')
                " for mac os,  fzf installed by brew
                set runtimepath+=/usr/local/opt/fzf
            elseif isdirectory(g:fzf_in_scoop)
                " for windows, fzf installed by scoop
                execute 'set runtimepath+=' . g:fzf_in_scoop
            elseif isdirectory(g:fzf_folder_via_git)
                " for apt install fzf on ubuntu
                " @see https://github.com/junegunn/fzf.vim/issues/456
                execute 'set runtimepath+=' . g:fzf_folder_via_git
            else
                echoerr 'Please set runtimepath for fzf'
            endif

            nnoremap <c-p> :Files<Cr>

            unlet g:fzf_folder_via_git
            unlet g:fzf_in_scoop
        endif
     " }

     " ctrlp {
        if count(g:spf13_bundle_groups, 'fzf') == 0
            let g:ctrlp_working_path_mode = 'w'
            let g:ctrlp_by_filename = 0
            let g:ctrlp_match_current_file = 1
            let g:ctrlp_lazy_update = 1
            let g:ctrlp_match_current_file = 1

            " @param {String} type  available values:
            "
            "  wildignore
            "  ctrlp_user_command
            "  ctrlp_custom_ignore_dir
            "  ctrlp_custom_ignore_file
            "
            " @return {String}
            "
            function! CreateIgnoredCommand(type)
                let l:directoryList = [
                                \ '.git',
                                \ '.gitmodules',
                                \ '.svn',
                                \ '.settings',
                                \ 'bower_components',
                                \ 'node_modules',
                                \ 'dist'
                            \]
                let l:fileListWithFullName = [
                        \ '.DS_Store'
                        \]

                let l:fileListWithEndName = [
                        \ 'png',
                        \ 'jpg',
                        \ 'gif',
                        \ 'class',
                        \ 'jar',
                        \ 'so'
                        \]

                let l:prefix = ''
                let l:suffix = ''
                let l:splitter = ' '
                let l:strList = []

                if a:type ==# 'wildignore'
                    let l:splitter = ','
                    for l:item in l:directoryList
                        call add(l:strList, '*/' . l:item . '/*')
                    endfor
                    for l:item in l:fileListWithFullName
                        call add(l:strList, l:item)
                    endfor
                    for l:item in l:fileListWithEndName
                        call add(l:strList, '*.' . l:item)
                    endfor
                elseif a:type ==# 'ctrlp_user_command_rg'
                    " let g:ctrlp_user_command = 'rg --files --smart-case --color "never" %s'
                    let l:prefix = 'rg %s --files --hidden --smart-case --color=never '
                    let l:suffix = ' --glob ""'
                    let l:splitter = ' '
                    for l:item in l:directoryList
                        call add(l:strList, '--iglob "!' . l:item . '"')
                    endfor
                    for l:item in l:fileListWithFullName
                        call add(l:strList, '--iglob "!' . l:item . '"')
                    endfor
                    for l:item in l:fileListWithEndName
                        call add(l:strList, '--iglob "!*.' . l:item . '"')
                    endfor
                elseif a:type ==# 'ctrlp_user_command'
                    let l:prefix = 'ag %s -i --nocolor --nogroup '
                    let l:suffix = ' --hidden -g ""'
                    let l:splitter = ' '
                    for l:item in l:directoryList
                        call add(l:strList, "--ignore '" . l:item . "'")
                    endfor
                    for l:item in l:fileListWithFullName
                        call add(l:strList, "--ignore '" . l:item . "'")
                    endfor
                    for l:item in l:fileListWithEndName
                        call add(l:strList, "--ignore '*." . l:item . "'")
                    endfor
                elseif a:type ==# 'ctrlp_custom_ignore_dir'
                    let l:prefix = '\v[\/]('
                    let l:suffix = ')$'
                    let l:splitter = '|'
                    for l:item in l:directoryList
                        if stridx(l:item, '.') == 0
                            call add(l:strList, '\' . l:item)
                        else
                            call add(l:strList, l:item)
                        endif
                    endfor
                elseif a:type ==# 'ctrlp_custom_ignore_file'
                    let l:prefix = '\v('
                    let l:suffix = ')$'
                    let l:splitter = '|'
                    for l:item in l:fileListWithFullName
                        if stridx(l:item, '.') == 0
                            call add(l:strList,  '\' . l:item)
                        else
                            call add(l:strList, l:item)
                        endif
                    endfor
                    for l:item in l:fileListWithEndName
                        call add(l:strList, '\.' .l:item)
                    endfor
                endif

                let l:commandStr = l:prefix . join(l:strList, l:splitter) . l:suffix
                return l:commandStr
            endfunction

            let g:vimrc_temp_str = 'set wildignore+=' .  CreateIgnoredCommand('wildignore')
            exec g:vimrc_temp_str
            unlet g:vimrc_temp_str

            if executable('rg')
                " @see https://www.philipbradley.net/posts/2017-03-29-ripgrep-with-ctrlp-and-vim/
                let g:ctrlp_user_command = CreateIgnoredCommand('ctrlp_user_command_rg')
                let g:ctrlp_use_caching = 0
            elseif executable('ag')
                let g:ctrlp_user_command = CreateIgnoredCommand('ctrlp_user_command')
                let g:ctrlp_use_caching = 0
            else
                let g:ctrlp_use_caching = 1
                let g:ctrlp_clear_cache_on_exit = 1
                let g:ctrlp_cache_dir = expand('~/.cache/ctrlp')
                let g:ctrlp_show_hidden = 1
                let g:ctrlp_max_files = 1000
                let g:ctrlp_custom_ignore = {}
                let g:ctrlp_custom_ignore['dir'] = CreateIgnoredCommand('ctrlp_custom_ignore_dir')
                let g:ctrlp_custom_ignore['file'] = CreateIgnoredCommand('ctrlp_custom_ignore_file')
            endif

        endif

     "}



     " posva/vim-vue {
        autocmd vimrc BufRead,BufNewFile,BufWritePre *.vue,*.wpy setlocal filetype=vue
        " let g:vue_disable_pre_processors = 1
        let g:vue_pre_processors = 'detect_on_enter'
        autocmd vimrc FileType vue syntax sync fromstart

        let g:ft = ''
        function! NERDCommenter_before()
          if &filetype ==# 'vue'
            let g:ft = 'vue'
            let l:stack = synstack(line('.'), col('.'))
            if len(l:stack) > 0
              let l:syn = synIDattr((l:stack)[0], 'name')
              if len(l:syn) > 0
                exe 'setf ' . substitute(tolower(l:syn), '^vue_', '', '')
              endif
            endif
          endif
        endfunction
        function! NERDCommenter_after()
          if g:ft ==# 'vue'
            setf vue
            let g:ft = ''
          endif
        endfunction
     " }
     "
     " FuDesign2008/component-kit.vim {
        " let g:kit_component_template_dir = 'built-in'
        let g:kit_component_auto_layout = 'disable'
     " }


     " nvie/vim-flake8 {
        autocmd vimrc BufWritePost *.py call Flake8()
     " }

     " fs111/pydoc.vim {
        let g:pydoc_perform_mappings = 0
     " }

     " PythonMode {
        let g:pymode_rope_complete_on_dot = 0
        let g:pymode_rope_lookup_project = 0
        let g:pymode_lint_write = 0
        let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
         " Disable if python support not present
        "if !has('python')
           "let g:pymode = 1
        "endif
     " }


     "ios devement {
        let g:clang_library_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang'

     " will133/vim-dirdiff' {
        let g:DirDiffExcludes = '.*'
        let g:DirDiffPreventSyntasticOpenLocationList = 1
     "}


     " mhinz/vim-startify {
        let g:startify_change_to_vcs_root = 1
     "}


     " guileen/vim-node-dict {
        autocmd vimrc FileType javascript set dictionary+=$HOME/.vim/vim-node-dict/dict/node.dict
     " }

     " jamessan/vim-gnupg{
        let g:GPGPreferArmor=1
        let g:GPGDefaultRecipients=['fudesign2008@163.com']
     " }

     " indent_guides {
        "if !exists('g:spf13_no_indent_guides_autocolor')
            "let g:indent_guides_auto_colors = 1
        "else
            " for some colorscheme ,autocolor will not work,like 'desert','ir_black'.
            "autocmd vimrc VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#212121   ctermbg=3
            "autocmd vimrc VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#404040 ctermbg=4
        "endif
        "set ts=4 sw=4 et
        "let g:indent_guides_start_level = 2
        "let g:indent_guides_guide_size = 1
        "let g:indent_guides_enable_on_vim_startup = 1
     " }

     " lervag/vimtex {
        let g:tex_flavor='latex'
     " }
     "  kristijanhusak/vim-carbon-now-sh {
     "  @see https://github.com/carbon-app/carbon/blob/main/lib/routing.js#L58
        let g:carbon_now_sh_options = {
            \ 'ln': 'true',
            \ 't': 'solarized light',
            \ 'bg': 'rgba(0,0,0,0)',
            \ 'fs': '12px',
            \ 'wc': 'false',
            \ 'wa': 'true',
            \ 'fm': 'Source Code Pro'
            \}
     " }

     " for code show {
        let g:goyo_linenr=1

        function! CodeShow()
          set background=light
          color Tomorrow
          set number
          set norelativenumber
          call SetGuiFont('Source\ Code\ Variable', g:gui_font_size)
          execute ':Goyo'
        endfunction

        function! CodeShowOff()
          execute ':Goyo!'
          set number
          set relativenumber
        endfunction

        command! -nargs=0 CodeShow :call CodeShow()
        command! -nargs=0 CodeShowOff :call CodeShowOff()
     " }

" }

" unlet helper {
    unlet g:vimrc_performance_low
    unlet g:vimrc_vue_version
"}

" GUI Settings {
    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        " 1. remove the toolbar
        " 2. f: run in foreground and not fork
        set guioptions=egmf
        set lines=40                " 40 lines of text instead of 24,
    else
        if &term ==? 'xterm' || &term ==? 'screen'
            set t_Co=256                 " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
        "set term=builtin_ansi       " Make arrow and other keys work
    endif

    "macVim - full screen in high sierra is buggy, so disable it
    " if has('gui_macvim')
        " set fullscreen
    " endif
" }

 " Functions {

function! UnBundle(arg, ...)
  let l:bundle = vundle#config#init_bundle(a:arg, a:000)
  call filter(g:bundles, 'v:val["name_spec"] != "' . a:arg . '"')
endfunction

com! -nargs=+         UnBundle
\ call UnBundle(<args>)

function! InitializeDirectories()
    let l:separator = '.'
    let l:parent = $HOME
    let l:prefix = '.vim'
    let l:dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let l:dir_list['undo'] = 'undodir'
    endif

    for [l:dirname, l:settingname] in items(l:dir_list)
        let l:directory = l:parent . '/' . l:prefix . l:dirname . '/'
        if exists('*mkdir')
            if !isdirectory(l:directory)
                call mkdir(l:directory)
            endif
        endif
        if !isdirectory(l:directory)
            echo 'Warning: Unable to create backup directory: ' . l:directory
            echo 'Try: mkdir -p ' . l:directory
        else
            let l:directory = substitute(l:directory, ' ', '\\\\ ', 'g')
            exec 'set ' . l:settingname . '=' . l:directory
        endif
    endfor
endfunction
call InitializeDirectories()

"function! NERDTreeInitAsNeeded()
    "redir => bufoutput
    "buffers!
    "redir END
    "let idx = stridx(bufoutput, "NERD_tree")
    "if idx > -1
        "NERDTreeMirror
        "NERDTreeFind
        "wincmd l
    "endif
"endfunction


" }

" Use fork vimrc if available {
    if filereadable(expand('~/.vimrc.fork'))
        source ~/.vimrc.fork
    endif
" }

" Use local vimrc if available {
    if filereadable(expand('~/.vimrc.local'))
        source ~/.vimrc.local
    endif
" }

" Use local gvimrc if available and gui is running {
    if has('gui_running')
        if filereadable(expand('~/.gvimrc.local'))
            source ~/.gvimrc.local
        endif
    endif
" }
