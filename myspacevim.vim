function! myspacevim#before() abort
  echo ok
endfunction

function! myspacevim#after() abort

  " https://vimrcfu.com/snippet/250
  " https://vi.stackexchange.com/a/15785

  if !has('nvim')
    set <A-a>=a
    set <A-b>=b
    set <A-c>=c
    set <A-d>=d
    set <A-e>=e
    set <A-f>=f
    set <A-h>=h
    set <A-j>=j
    set <A-k>=k
    set <A-l>=l
    set <A-r>=r
    set <A-S>=S
    set <A-s>=s
    set <A-t>=t
    set <A-u>=u
    set <A-.>=.
  endif

" https://github.com/liuchengxu/space-vim/issues/356
" https://github.com/liuchengxu/vim-better-default/blob/d6239473fa22429564efdd72d7e4407c6b744718/plugin/default.vim#L103-L123
" Change cursor shape for iTerm2 on macOS {
  " bar in Insert mode
  " inside iTerm2
if $TERM_PROGRAM =~# 'iTerm'
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" inside tmux
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
endif

" inside neovim
if has('nvim')
  set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkon100
else
  let &t_SI.="\e[5 q" "SI = start INSERT mode
  let &t_SR.="\e[4 q" "SR = start REPLACE mode
  let &t_EI.="\e[1 q" "EI = end insert mode NORMAL mode (ELSE)
endif

let mapleader='\' " backslash sends tab when held and may not work well as leader

" https://github.com/kana/vim-textobj-entire/blob/64a856c9dff3425ed8a863b9ec0a21dbaee6fb3a/doc/textobj-entire.txt#L91
let g:textobj_entire_no_default_key_mappings = 1

" https://github.com/unblevable/quick-scope#highlight-on-key-press
" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Map the leader key + q to toggle quick-scope's highlighting in normal/visual mode.
" Note that you must use nmap/xmap instead of their non-recursive versions (nnoremap/xnoremap).
let g:qs_enable=0
nmap <leader>q <plug>(QuickScopeToggle)
xmap <leader>q <plug>(QuickScopeToggle)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" https://til.hashrocket.com/posts/17c44eda91-persistent-folds-between-vim-sessions
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

autocmd FileType pandoc,markdown setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" https://github.com/SpaceVim/SpaceVim/issues/470
autocmd ColorScheme molokai highlight EndOfBuffer ctermbg=NONE guibg=NONE
autocmd ColorScheme molokai highlight LineNr     ctermbg=NONE guibg=NONE
autocmd ColorScheme molokai highlight NonText ctermbg=NONE guibg=NONE
autocmd ColorScheme molokai highlight Normal ctermbg=NONE guibg=NONE
autocmd ColorScheme molokai highlight SignColumn ctermbg=NONE guibg=NONE
autocmd ColorScheme molokai highlight VertSplit ctermbg=NONE guibg=NONE

" https://jovicailic.org/2017/04/vim-persistent-undo/
set undofile
if has('nvim')
  set undodir=~/.local/share/nvim/undo
else
  set undodir=~/.vim/undodir
endif

" Share system clipboard ("+) and unnamed ("") registers
" http://vimcasts.org/episodes/accessing-the-system-clipboard-from-vim/
" http://vimcasts.org/blog/2013/11/getting-vim-with-clipboard-support/
set clipboard=unnamed
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif
set go+=a

set fillchars+=vert:│
set laststatus=0
highlight EndOfBuffer ctermbg=NONE guibg=NONE
highlight LineNr     ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight Normal ctermbg=NONE guibg=NONE ctermfg=white guifg=white
highlight SignColumn ctermbg=NONE guibg=NONE
highlight VertSplit ctermbg=NONE guibg=NONE
highlight Terminal ctermbg=NONE guibg=NONE ctermfg=white guifg=white
highlight Pmenu ctermbg=NONE guibg=NONE
" coc handles highlighting for the popup menu
" hi PmenuSel   ctermfg=15  ctermbg=27
" hi PmenuSbar  ctermfg=7  ctermbg=0
" hi PmenuThumb ctermfg=15  ctermbg=27

set nonu

"*****************************************************************************
"" Mappings
"*****************************************************************************

" remap entire text object to match doom emacs
" https://docs.doomemacs.org/v21.12/modules/editor/evil/
onoremap	ag	<Plug>(textobj-entire-a)
onoremap	ig	<Plug>(textobj-entire-i)
xnoremap	ag	<Plug>(textobj-entire-a)
xnoremap	ig	<Plug>(textobj-entire-i)

function! MakeItEasyToLeaveCommandWindow()
  nnoremap <buffer> ZZ <C-c><Esc>
  nnoremap <buffer> ZQ <C-c><Esc>
  nnoremap <buffer> <C-c> <C-c><Esc>
endfunction

" No need to undo
au CmdwinEnter * silent! call MakeItEasyToLeaveCommandWindow()

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
if !has('nvim')
" https://github.com/vim/vim/issues/4738
nnoremap gx yiW:!open <cWORD><CR> <C-r>" & <CR><CR>
endif
" unimpaired style mapping for toggling autoformat
nnoremap <expr> yoa &fo =~ 'a' ? ':set fo-=a<CR>' : ':set fo+=a<CR>'

vmap gy <Plug>(Exchange)
nmap gy <Plug>(Exchange)

" brilliant mapping to toggle emacs-style ctrl-k mapping
" https://vi.stackexchange.com/a/15579
let s:ctrlKmapped=1

function! ToggleCtrlK()
    if s:ctrlKmapped
        iunmap <C-k>
    else
        inoremap <expr> <C-k> col('.') == col('$') ? '<Del>' : '<C-o>d$'
    endif
    let s:ctrlKmapped = !s:ctrlKmapped
endfunction

nnoremap yok :call ToggleCtrlK()<CR>

" brilliant mapping to toggle emacs-style ctrl-v mapping
" https://vi.stackexchange.com/a/15579
let s:ctrlVmapped=1

function! ToggleCtrlV()
    if s:ctrlVmapped
        iunmap <C-v>
    else
        inoremap <C-v> <PageDown>
    endif
    let s:ctrlVmapped = !s:ctrlVmapped
endfunction

nnoremap yov :call ToggleCtrlV()<CR>

" pbcopy for OSX copy/paste
if has('macunix')
  xmap <D-x> :!pbcopy<CR>
  xmap <D-c> :w !pbcopy<CR><CR>
endif

"" Vmap for maintain Visual Mode after shifting > and <
xmap < <gv
xmap > >gv

"" Move visual block
xnoremap J :m '>+1<CR>gv=gv
xnoremap K :m '<-2<CR>gv=gv

" https://vi.stackexchange.com/a/22233
" copied from plugin/surround.vim
nmap  ds   <Plug>Dsurround
nmap  cs   <Plug>Csurround
nmap  cS   <Plug>CSurround
nmap  ys   <Plug>Ysurround
nmap  yS   <Plug>YSurround
nmap  yss  <Plug>Yssurround
nmap  ySs  <Plug>YSsurround
nmap  ySS  <Plug>YSsurround
xmap  S    <Plug>VSurround
xmap  gS   <Plug>VgSurround
imap <C-S> <Plug>Isurround
" ----- remove these -----
" imap    <C-G>s <Plug>Isurround
" imap    <C-G>S <Plug>ISurround

" Emacs and bash style insert mode CTRL shortcuts
" <C-a> = Move to start of the line; like in vim command mode: c_ctrl-b; To insert previously inserted text, use <C-r>. or <Alt-.> (below)
inoremap <C-a> <Home>
cnoremap <C-a> <Home>
" <C-b> = Move one character backward; the opposite of <C-f>
inoremap <C-b> <Left>
cnoremap <C-b> <Left>
" <C-d> = Delete one character forward; the opposite of <C-h>
inoremap <silent><expr> <C-d> "\<C-g>u<Delete>"
cnoremap <C-d> <Delete>
" <C-e> = Move to end of the line (already exists in command mode: c_ctrl-e), this also cancels completion
inoremap <C-e> <End>
" <C-f> = Move one character forward; the opposite of <C-b>; <C-f> is too useful (for : / ?) to remap
inoremap <C-f> <Right>
" <C-g> = Cancel completion
inoremap <silent><expr> <C-g> pumvisible() ? "\<C-e>" :  "<C-g>"
" <C-h> = Delete one character backward; the opposite of <C-d>; already exists in command mode: c_ctrl-h
inoremap <silent><expr> <C-h> "\<C-g>u<BS>"
" <C-k> = Delete to end of line; the opposite of <C-u>; https://www.reddit.com/r/vim/comments/9i58q8/question_re_delete_word_forward_in_insert_mode/e6he226/; https://superuser.com/a/855997
inoremap <expr> <C-k> col(".") == col("$") ? "<Del>" : "<C-o>d$"
cnoremap <C-k> <C-\>estrpart(getcmdline(),0,getcmdpos()-1)<CR>
" cnoremap <C-k> <C-f>d$<C-c><End>
" <C-r> = make paste from register undoable in insert mode; already exists in command mode: c_ctrl-r
inoremap <silent><expr> <C-r> "\<C-g>u<C-r>"
" <C-u> = Delete to start of line; the opposite of <C-k>; already exists in command mode: c_ctrl-u
inoremap <silent><expr> <C-u> "\<C-g>u<C-u>"
" <C-w> = Delete word backward; opposite of <A-d>; same as <A-h>; already exists in command mode: c_ctrl-w
inoremap <silent><expr> <C-w> "\<C-g>u<C-w>"
" <C-y> = Paste from system clipboard (not from killring like in bash/emacs)
inoremap <silent> <C-y> <C-o>:call <SID>ResetKillRing()<CR><C-r><C-o>"
cnoremap <C-y> <C-r><C-o>"
" <C-_> = Undo like in bash/emacs (this works really well)
inoremap <C-_> <C-o>u
inoremap <C-x><C-u> <C-o>u
" <C-/> = Undo like in bash/emacs (this works really well)
inoremap <C-/> <C-o>u
" <C-=> = Redo; opposite of <C-_>
inoremap <C-=> <C-o><C-r>
" Vimacs
imap <C-@> <C-Space>
inoremap <C-<> <C-o>:call <SID>StartMarkSel()<CR><C-o>v1G0o
inoremap <C->> <C-o>:call <SID>StartMarkSel()<CR><C-o>vG$o
inoremap <C-M-%> <C-o>:call <SID>QueryReplaceRegexp()<CR>
inoremap <C-M-/> <C-x>
inoremap <C-M-o> <C-o>:echoerr "<C-M-o> not supported yet; sorry!"<CR>
inoremap <C-M-r> <C-o>:call <SID>StartSearch('?')<CR><C-o>?
inoremap <C-M-s> <C-o>:call <SID>StartSearch('/')<CR><C-o>/
inoremap <C-M-x> <C-x>
inoremap <C-S-Tab> <C-o><C-w>W
inoremap <C-Tab> <C-o><C-w>w
inoremap <C-]> <C-x>
inoremap <C-s> <C-o>:call <SID>StartSearch('/')<CR><C-o>/
inoremap <C-t> <Left><C-o>x<C-o>p
inoremap <C-v> <PageDown>
inoremap <C-x>+ <C-o><C-w>=
inoremap <C-x>/ <C-o>:call <SID>PointToRegister()<CR>
inoremap <C-x>0 <C-o><C-w>c
inoremap <C-x>1 <C-o><C-w>o
inoremap <C-x>2 <C-o><C-w>s
inoremap <C-x>3 <C-o><C-w>v
inoremap <C-x>4<C-f> <C-o>:FindFileOtherWindow<Space>
inoremap <C-x>4f <C-o>:FindFileOtherWindow<Space>
inoremap <C-x><BS> <C-o>d(
inoremap <C-x><C-b> <C-o>:buffers<CR>
inoremap <C-x><C-c> <C-o>:confirm qall<CR>
inoremap <C-x><C-f> <C-o>:hide edit<Space>
inoremap <C-x><C-o> <C-o>:call <SID>DeleteBlankLines()<CR>
inoremap <C-x><C-q> <C-o>:set invreadonly<CR>
inoremap <C-x><C-r> <C-o>:hide view<Space>
inoremap <C-x><C-s> <C-o>:update<CR>
inoremap <C-x><C-t> <Up><C-o>dd<End><C-o>p<Down>
inoremap <C-x><C-w> <C-o>:write<Space>
inoremap <C-x>= <C-g>
inoremap <C-x>O <C-o><C-w>W
inoremap <C-x>h <C-o>:call <SID>StartMarkSel()<CR><Esc>1G0vGo
inoremap <C-x>i <C-o>:read<Space>
inoremap <C-x>k <C-o>:bdelete<Space>
inoremap <C-x>o <C-o><C-w>w
inoremap <C-x>p <C-o><C-o>
inoremap <C-x>r<C-@> <C-o>:call <SID>PointToRegister()<CR>
inoremap <C-x>r<C-Space> <C-o>:call <SID>PointToRegister()<CR>
inoremap <C-x>r<Space> <C-o>:call <SID>PointToRegister()<CR>
inoremap <C-x>rj <C-o>:call <SID>JumpToRegister()<CR>
inoremap <C-x>s <C-o>:wall<CR>
inoremap <script> <C-o> <CR><Left>
inoremap <silent> <C-M-v> <C-o>:ScrollOtherWindow<CR>
inoremap <silent> <C-Space> <C-r>=<SID>StartVisualMode()<CR>
vnoremap <C-M-\> =
vnoremap <C-g> <Esc>
vnoremap <C-w> "1d
vnoremap <C-x><C-@> <Esc>
vnoremap <C-x><C-Space> <Esc>
vnoremap <C-x><Tab> =

" " Emacs and bash style insert mode ALT shortcuts
" " <A-a> = Move to previous sentence start ; opposite of <A-e>
if !has('nvim')
set <A-a>=a
endif
nnoremap <A-a> (
inoremap <A-a> <C-o>(
" <A-b> = Move one word backward; opposite of <A-f>
if !has('nvim')
set <A-b>=b
endif
nnoremap <A-b> b
inoremap <A-b> <S-Left>
cnoremap <A-b> <S-Left>
" <A-c> = Capitalize letter and move forward
" https://github.com/andrep/vimacs/blob/master/plugin/vimacs.vim#L1229
if !has('nvim')
set <A-c>=c
endif
nnoremap <A-c> gUllgueea
inoremap <expr> <A-c> getline('.')[col('.')-1] =~ "\\s" ? "<C-o>W<C-o>gUl<C-o>l<C-o>guw<Esc>ea" : "<C-o>gUl<C-o>l<C-o>guw<Esc>ea"
" <A-d> = Delete word forward; opposite of <A-h> and <C-w>; https://www.reddit.com/r/vim/comments/9i58q8/question_re_delete_word_forward_in_insert_mode/e6he226/
if !has('nvim')
set <A-d>=d
endif
nnoremap <A-d> dw
inoremap <expr> <A-d> col(".") == col("$") ? "<Del>" : "<C-o>de"
cnoremap <A-d> <S-Right><C-w>
" " <A-e> = Move to previous sentence start ; opposite of <A-a>
if !has('nvim')
set <A-e>=e
endif
nnoremap <A-e> )T.
inoremap <A-e> <Esc>)T.i
" <A-f> = Move one word forward; opposite of <A-b>
if !has('nvim')
set <A-f>=f
endif
nnoremap <A-f> w
inoremap <A-f> <S-Right>
cnoremap <A-f> <S-Right>
" <A-h> = Delete word backward; opposite of <A-d>; same as <C-w>
if !has('nvim')
set <A-h>=h
endif
nnoremap <A-h> db
inoremap <silent><expr> <A-h> "\<C-g>u<C-w>"
cnoremap <A-h> <C-w>
" <A-j> = Move down; opposite of <A-k>
if !has('nvim')
set <A-j>=j
endif
inoremap <A-j> <Down>
cnoremap <A-j> <Down>
" " <A-k> = Delete to end of sentence
if !has('nvim')
set <A-k>=k
endif
nnoremap <A-k> df.
inoremap <A-k> <C-o>df.
" <A-l> = Lowercase to word end; opposite of <A-u>
" https://github.com/andrep/vimacs/blob/master/plugin/vimacs.vim#L1229
if !has('nvim')
set <A-l>=l
endif
inoremap <A-l> <C-o>gue<Esc>ea
cnoremap <A-l> <C-f>guee<C-c>
" <A-u> = Uppercase to WORD end; opposite of <A-l>
" https://github.com/andrep/vimacs/blob/master/plugin/vimacs.vim#L1229
if !has('nvim')
set <A-u>=u
endif
nnoremap <A-u> gUeea
inoremap <A-u> <C-o>gUe<Esc>ea
cnoremap <A-u> <C-f>gUee<C-c>
" " <A-q> = Fill / Format paragraph
if !has('nvim')
set <A-q>=q
endif
nnoremap <A-q> gwip
inoremap <A-q> <C-o>gwip
" <A-.> = Insert previously inserted text (if any)
if !has('nvim')
set <A-.>=.
endif
nnoremap <A-.> a<C-r>.
inoremap <A-.> <Esc>a<C-r>.
cnoremap <A-.> <C-r>.
" Vimacs
inoremap <C-x>4. <C-o><C-w>}
inoremap <M-!> <C-o>:!
inoremap <M-%> <C-o>:call <SID>QueryReplace()<CR>
inoremap <M-*> <C-o><C-t>
inoremap <M-.> <C-o><C-]>
inoremap <M-/> <C-p>
inoremap <M-0><C-k> <C-o>d0
inoremap <M-1> <C-o>1
inoremap <M-2> <C-o>2
inoremap <M-3> <C-o>3
inoremap <M-4> <C-o>4
inoremap <M-5> <C-o>5
inoremap <M-6> <C-o>6
inoremap <M-7> <C-o>7
inoremap <M-8> <C-o>8
inoremap <M-9> <C-o>9
inoremap <M-:> <C-o>:
inoremap <M-<> <C-o>1G<C-o>0
inoremap <M->> <C-o>G<C-o>$
inoremap <M-Space> <C-o>:call <SID>StartMarkSel()<CR><C-o>viw
inoremap <M-\> <Esc>beldwi
inoremap <M-^> <Up><End><C-o>J
inoremap <M-`> <C-o>
inoremap <M-h> <C-o>:call <SID>StartMarkSel()<CR><C-o>vapo
inoremap <M-k> <C-o>d)
inoremap <M-m> <C-o>^
inoremap <M-n> <C-o>:cnext<CR>
inoremap <M-p> <C-o>:cprevious<CR>
inoremap <M-r> <C-r>=
inoremap <M-s> <C-o>:set invhls<CR>
inoremap <M-v> <PageUp>
inoremap <M-x> <C-o>:
inoremap <M-y> <C-o>:call <SID>YankPop()<CR>
inoremap <M-z> <C-o>dt
inoremap <silent> <M-g> <C-o>:call <SID>GotoLine()<CR>
inoremap <silent> <M-q> <C-o>:call <SID>FillParagraph()<CR>
vnoremap <M-!> !
vnoremap <M-h> o}o
vnoremap <M-w> "1y
vnoremap <M-x> :

"" Git
nnoremap [g :diffget //2<CR>
nnoremap ]g :diffget //3<CR>
" nnoremap <silent><leader>gw :Gwrite<CR>
" nnoremap <silent><leader>gc :Gwrite<bar>Gcommit<CR>
" nnoremap <leader>gp :Gpush<CR>
" nnoremap <leader>gu :Gpull<CR>
" nnoremap <leader>gd :Gvdiff<CR>
" nnoremap <leader>gr :Gremove<CR>
" nnoremap <leader>gl :Glog<CR>
" nnoremap <leader>gg :Gwrite<CR>:Gcommit -m "edit "%<CR>:Gpush<CR>

nmap gs <Plug>(easymotion-prefix)
" differs from gsf in that it is bidirectional and works across windows
nmap gsf <Plug>(easymotion-overwin-f)
" there is no gsl in the default mappings
nmap gsl <Plug>(easymotion-overwin-line)
" differs from the original gss in that it works across windows and uses two characters
nmap gss <Plug>(easymotion-overwin-f2)
" differs from the original gsw in that it is bidirectional and works across windows
nmap gsw <Plug>(easymotion-overwin-w)
" All of the above are bidirectional and work across windows
" All of the remaining are unidirectional and do work across windows:
" f, F, t, T, w, W, b, B, e, E, ge, gE, j, k, n, N, s, S
xmap gsf <Plug>(easymotion-f)
omap gsf <Plug>(easymotion-f)
xmap gsF <Plug>(easymotion-F)
omap gsF <Plug>(easymotion-F)
xmap gst <Plug>(easymotion-t)
omap gst <Plug>(easymotion-t)
xmap gsT <Plug>(easymotion-T)
omap gsT <Plug>(easymotion-T)
xmap gsw <Plug>(easymotion-w)
omap gsw <Plug>(easymotion-w)
xmap gsW <Plug>(easymotion-W)
omap gsW <Plug>(easymotion-W)
xmap gsb <Plug>(easymotion-b)
omap gsb <Plug>(easymotion-b)
xmap gsB <Plug>(easymotion-B)
omap gsB <Plug>(easymotion-B)
xmap gse <Plug>(easymotion-e)
omap gse <Plug>(easymotion-e)
xmap gsE <Plug>(easymotion-E)
omap gsE <Plug>(easymotion-E)
xmap gsge <Plug>(easymotion-ge)
omap gsge <Plug>(easymotion-ge)
xmap gsgE <Plug>(easymotion-gE)
omap gsgE <Plug>(easymotion-gE)
xmap gsj <Plug>(easymotion-j)
omap gsj <Plug>(easymotion-j)
xmap gsk <Plug>(easymotion-k)
omap gsk <Plug>(easymotion-k)
xmap gsn <Plug>(easymotion-n)
omap gsn <Plug>(easymotion-n)
xmap gsN <Plug>(easymotion-N)
omap gsN <Plug>(easymotion-N)
xmap gss <Plug>(easymotion-f2)
omap gss <Plug>(easymotion-f2)
xmap gsS <Plug>(easymotion-F2)
omap gsS <Plug>(easymotion-F2)

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Make the substitution command easier to use
" Ampersand (&), which represents the search query, is selected via select mode, so you can:
" - Type in the replacement text immediately
" - Press enter to delete all matches
" - Press escape then enter to use the search query as the replacement text (can be used as a test)
" - Press escape then a or i to appended or prepended text (respectively) to the search query
nnoremap <leader>a :arga **/*.<C-r>=expand("%:e")<CR><C-f>A \| argdo %s//&/ge \| up<C-left><C-left><C-left><left><Esc>gh
nnoremap <leader>b :<C-f>ibufdo %s//&/ge \| up<C-left><C-left><C-left><left><Esc>gh
nnoremap <leader>c :let @/=substitute(substitute(escape(@/, '/'), '^\\<', '', 'g'), '\\>$', '', 'g')<CR>:silent grep! "<C-r>/" * .[^.]*<CR>:copen<CR>:set modifiable<CR>:<C-f>icdo s//&/ge \| up<C-left><C-left><C-left><left><Esc>gh
nnoremap <leader>l :let @/=substitute(substitute(escape(@/, '/'), '^\\<', '', 'g'), '\\>$', '', 'g')<CR>:silent lgrep! "<C-r>/" * .[^.]*<CR>:lopen<CR>:set modifiable<CR>:<C-f>ild s//&/ge \| up<C-left><C-left><C-left><left><Esc>gh
nnoremap <leader>s :<C-f>i%s//&/ge<C-left><left><Esc>gh
nnoremap <leader>w :<C-f>iwindo %s//&/ge \| up<C-left><C-left><C-left><left><Esc>gh
xnoremap <leader>a y:let @/=substitute(escape(@0, '/'), '\n', '\\n', 'g')<CR>:arga **/*.<C-r>=expand("%:e")<CR><C-f>A \| argdo %s//&/ge \| up<C-left><C-left><C-left><left><Esc>gh
xnoremap <leader>b y:let @/=substitute(escape(@0, '/'), '\n', '\\n', 'g')<CR>:<C-f>ibufdo %s//&/ge \| up<C-left><C-left><C-left><left><Esc>gh
xnoremap <leader>c y:let @/=substitute(escape(@0, '/'), '\n', '\\n', 'g')<CR>:grep -r "<C-r>0" * .[^.]* --exclude-dir={.git,tags}<CR><C-o>:copen<CR>:set modifiable<CR>:<C-f>icdo s//&/ge \| up<C-left><C-left><C-left><left><Esc>gh
xnoremap <leader>l y:let @/=substitute(escape(@0, '/'), '\n', '\\n', 'g')<CR>:lgrep -r "<C-r>0" * .[^.]* --exclude-dir={.git,tags}<CR><C-o>:lopen<CR>:set modifiable<CR>:<C-f>ild s//&/ge \| up<C-left><C-left><C-left><left><Esc>gh
xnoremap <leader>s y:let @/=substitute(escape(@0, '/'), '\n', '\\n', 'g')<CR>:<C-f>i%s//&/ge<C-left><left><Esc>gh
xnoremap <leader>w y:let @/=substitute(escape(@0, '/'), '\n', '\\n', 'g')<CR>:<C-f>iwindo %s//&/ge \| up<C-left><C-left><C-left><left><Esc>gh

" https://vonheikemen.github.io/devlog/tools/how-to-survive-without-multiple-cursors-in-vim/#replace-a-selection
nnoremap <C-n> *``"_cgn
nnoremap <C-p> *``"_cgN
xnoremap <C-n> y:let @/=substitute(escape(@0, '/'), '\n', '\\n', 'g')<CR>"_cgn
xnoremap <C-p> y:let @/=substitute(escape(@0, '/'), '\n', '\\n', 'g')<CR>"_cgN

" Make using the g command easier
nnoremap <leader>g :<C-f>ig//
xnoremap <leader>g y:let @/=substitute(escape(@0, '/'), '\n', '\\n', 'g')<CR>:<C-f>i'<,'>g//

" Make using the v command easier
nnoremap <leader>v :<C-f>iv//
xnoremap <leader>v y:let @/=substitute(escape(@0, '/'), '\n', '\\n', 'g')<CR>:<C-f>i'<,'>v//

"" Opens an edit command with the path of the currently edited file filled in
noremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

nnoremap <silent> <leader>n :NERDTreeToggle<CR>

" terminal emulation
nnoremap <silent> <leader>t :terminal<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><leader> :noh<cr>

"" Open current line on GitHub
nnoremap <leader>o :.Gbrowse<CR>

nnoremap <silent> <leader>A :Ag<CR>
" use gb instead
" nnoremap <silent> <leader>b :Buffers<CR>
"Recovery commands from history through FZF
" nnoremap <silent> <leader>h :History<CR>
nnoremap <silent> <leader>B :BCommits<CR>
nnoremap <silent> <leader>C :Commands<CR>
nnoremap <silent> <leader>gf :GFiles<CR>
nnoremap <silent> <leader>F :Files<CR>
nnoremap <silent> <leader>H :Helptags<CR>
nnoremap <silent> <leader>M :Maps<CR>
nnoremap <silent> <leader>' :Marks<CR>
nnoremap <silent> <leader>L :Lines<CR>
nnoremap <silent> <leader>R :Rg<CR>
nnoremap <silent> <leader>T :Tags<CR>
nnoremap <silent> <leader>z :FZF -m<CR>

" https://github.com/junegunn/fzf.vim#mappings
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
" https://github.com/junegunn/fzf.vim#mappings
imap <C-x><C-a> <plug>(fzf-complete-file-ag)
imap <C-x><C-b> <plug>(fzf-complete-buffer-line)
imap <C-x><C-f> <plug>(fzf-complete-file)
imap <C-x><C-l> <plug>(fzf-complete-line)
imap <C-x><C-d> <plug>(fzf-complete-path)
imap <C-x><C-w> <plug>(fzf-complete-word)
imap <C-x>a <plug>(fzf-complete-file-ag)
imap <C-x>b <plug>(fzf-complete-buffer-line)
imap <C-x>f <plug>(fzf-complete-file)
imap <C-x>l <plug>(fzf-complete-line)
imap <C-x>d <plug>(fzf-complete-path)
imap <C-x>w <plug>(fzf-complete-word)

let g:maximizer_set_default_mapping = 0
nnoremap <silent><C-w>o :MaximizerToggle<CR>
xnoremap <silent><C-w>o :MaximizerToggle<CR>gv
nnoremap <C-w>c :mksession! ~/session.vim<CR>:wincmd c<CR>:file<CR>
nnoremap <C-w>q :mksession! ~/session.vim<CR>:wincmd q<CR>:file<CR>
" https://vi.stackexchange.com/questions/241/undo-only-window
nnoremap <C-w>u :silent :source ~/session.vim<CR>

" e is easier to reach than = and is unbound by default
nnoremap <C-w>e <C-w>=
" = is easier to type than +
nnoremap <C-w>= <C-w>+
" , is easier to type than < and is unbound by default
nnoremap <C-w>, <C-w><
" . is easier to type than < and is unbound by default
nnoremap <C-w>. <C-w>>
if has('nvim')
" Terminal like in vim
    tnoremap <C-w>+ <C-\><C-n><C-w>+
    tnoremap <C-w>- <C-\><C-n><C-w>-
    tnoremap <C-w>< <C-\><C-n><C-w><
    tnoremap <C-w>= <C-\><C-n><C-w>=
    tnoremap <C-w>> <C-\><C-n><C-w>>
    tnoremap <C-w>H <C-\><C-n><C-w>H
    tnoremap <C-w>J <C-\><C-n><C-w>J
    tnoremap <C-w>K <C-\><C-n><C-w>K
    tnoremap <C-w>L <C-\><C-n><C-w>L
    tnoremap <C-w>N <C-\><C-n>
    tnoremap <C-w>P <C-\><C-n><C-w>P
    tnoremap <C-w>R <C-\><C-n><C-w>R
    tnoremap <C-w>S <C-\><C-n><C-w>S
    tnoremap <C-w>T <C-\><C-n><C-w>T
    tnoremap <C-w>W <C-\><C-n><C-w>W
    tnoremap <C-w>] <C-\><C-n><C-w>]
    tnoremap <C-w>^ <C-\><C-n><C-w>^
    tnoremap <C-w>_ <C-\><C-n><C-w>_
    tnoremap <C-w>b <C-\><C-n><C-w>b
    tnoremap <C-w>c <C-\><C-n><C-w>c
    tnoremap <C-w>d <C-\><C-n><C-w>d
    tnoremap <C-w>f <C-\><C-n><C-w>f
    tnoremap <C-w>g <C-\><C-n><C-w>g
    tnoremap <C-w>h <C-\><C-n><C-w>h
    tnoremap <C-w>i <C-\><C-n><C-w>i
    tnoremap <C-w>j <C-\><C-n><C-w>j
    tnoremap <C-w>k <C-\><C-n><C-w>k
    tnoremap <C-w>l <C-\><C-n><C-w>l
    tnoremap <C-w>n <C-\><C-n><C-w>n
    tnoremap <C-w>o <C-\><C-n><C-w>o
    tnoremap <C-w>p <C-\><C-n><C-w>p
    tnoremap <C-w>q <C-\><C-n><C-w>q
    tnoremap <C-w>r <C-\><C-n><C-w>r
    tnoremap <C-w>s <C-\><C-n><C-w>s
    tnoremap <C-w>t <C-\><C-n><C-w>t
    tnoremap <C-w>v <C-\><C-n><C-w>v
    tnoremap <C-w>w <C-\><C-n><C-w>w
    tnoremap <C-w>x <C-\><C-n><C-w>x
    tnoremap <C-w>z <C-\><C-n><C-w>z
    tnoremap <C-w>} <C-\><C-n><C-w>}
    tnoremap <C-w>: <C-\><C-n>:
    tnoremap <C-w><C-b> <C-\><C-n><C-w>b
    tnoremap <C-w><C-c> <C-\><C-n><C-w>c
    tnoremap <C-w><C-d> <C-\><C-n><C-w>d
    tnoremap <C-w><C-f> <C-\><C-n><C-w>f
    tnoremap <C-w><C-g> <C-\><C-n><C-w>g
    tnoremap <C-w><C-h> <C-\><C-n><C-w>h
    tnoremap <C-w><C-i> <C-\><C-n><C-w>i
    tnoremap <C-w><C-j> <C-\><C-n><C-w>j
    tnoremap <C-w><C-k> <C-\><C-n><C-w>k
    tnoremap <C-w><C-l> <C-\><C-n><C-w>l
    tnoremap <C-w><C-n> <C-\><C-n><C-w>n
    tnoremap <C-w><C-o> <C-\><C-n><C-w>o
    tnoremap <C-w><C-p> <C-\><C-n><C-w>p
    tnoremap <C-w><C-q> <C-\><C-n><C-w>q
    tnoremap <C-w><C-r> <C-\><C-n><C-w>r
    tnoremap <C-w><C-s> <C-\><C-n><C-w>s
    tnoremap <C-w><C-t> <C-\><C-n><C-w>t
    tnoremap <C-w><C-v> <C-\><C-n><C-w>v
    tnoremap <C-w><C-w> <C-\><C-n><C-w>w
    tnoremap <C-w><C-x> <C-\><C-n><C-w>x
    tnoremap <C-w><C-z> <C-\><C-n><C-w>z
    tnoremap <C-w><C-]> <C-\><C-n><C-w>]
    tnoremap <C-w><C-^> <C-\><C-n><C-w>^
    tnoremap <C-w><C-_> <C-\><C-n><C-w>_
    tnoremap <C-w>; <C-\><C-n>:bn<CR>
    tnoremap <C-w>, <C-\><C-n>:bp<CR>
    nnoremap <C-w>; <C-\><C-n>:bn<CR>
    nnoremap <C-w>, <C-\><C-n>:bp<CR>
endif
" Fuzzy finder (FZF)
" https://jesseleite.com/posts/2/its-dangerous-to-vim-alone-take-fzf
nnoremap <silent> gB :BCommits<CR>
nnoremap <silent> gb :Buffers<CR>
nnoremap <silent> g: :History:<CR>
nnoremap <silent> g/ :History/<CR>

" Insert mode completion
" https://github.com/junegunn/fzf.vim#mappings
imap <c-x><c-a> <plug>(fzf-complete-file-ag)
imap <c-x><c-b> <plug>(fzf-complete-buffer-line)
imap <c-x><c-f> <plug>(fzf-complete-file)
imap <c-x><c-l> <plug>(fzf-complete-line)
imap <c-x><c-d> <plug>(fzf-complete-path)
imap <c-x><c-w> <plug>(fzf-complete-word)
imap <c-x>a <plug>(fzf-complete-file-ag)
imap <c-x>b <plug>(fzf-complete-buffer-line)
imap <c-x>f <plug>(fzf-complete-file)
imap <c-x>l <plug>(fzf-complete-line)
imap <c-x>d <plug>(fzf-complete-path)
imap <c-x>w <plug>(fzf-complete-word)

" Use <C-x><C-o> to activate vim omnicompletion
iunmap <C-x><C-o>

nnoremap <silent> <leader>' :Marks!<CR>
nnoremap <silent> <leader>/ :History/!<CR>
nnoremap <silent> <leader>: :History:!<CR>
nnoremap <silent> <leader>? :Helptags!<CR>
nnoremap <silent> <leader>A :Ag!<CR>
" nnoremap <silent> <leader>b :Buffers!<CR>
" nnoremap <silent> <leader>c :Commits!<CR>
nnoremap <silent> <leader>C :BCommits!<CR>
" nnoremap <silent> <leader>f :Files!<CR>
nnoremap <silent> <leader>F :Filetypes!<CR>
nnoremap <silent> <leader>gf :GFiles!<CR>
nnoremap <silent> <leader>h :History!<CR>
" nnoremap <silent> <leader>l :Lines!<CR>
nnoremap <silent> <leader>L :BLines!<CR>
nnoremap <silent> <leader>m :Maps!<CR>
nnoremap <silent> <leader>r :Rg!<CR>
" nnoremap <silent> <leader>s :Snippets!<CR>
" nnoremap <silent> <leader>t :Tags!<CR>
nnoremap <silent> <leader>T :BTags!<CR>
" nnoremap <silent> <leader>w :Windows!<CR>
nnoremap <silent> <leader>x :Commands!<CR>
nnoremap <silent> <leader>z :FZF! -m<CR>

" https://github.com/junegunn/fzf.vim#mappings
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" https://github.com/junegunn/fzf.vim#completion-functions
" Path completion with custom source command
inoremap <expr> <c-x><c-r> fzf#vim#complete#path('rg --files')
inoremap <expr> <c-x>r fzf#vim#complete#path('rg --files')
inoremap <expr> <c-x><c-d> fzf#vim#complete#path('exa --only-dirs')
inoremap <expr> <c-x>d fzf#vim#complete#path('exa --only-dirs')

" Mappings inspired by my .zshrc
imap <c-x><c-u> <C-o>u
imap <c-x>u <C-o>u
imap <c-x><c-x> <C-o>``
imap <c-x>x <C-o>``

if has('nvim')
" https://vim.fandom.com/wiki/Moving_through_camel_case_words
" Stop on capital letters, numbers, and the symbols below:
let g:camelchar = "A-Z0-9.,;:{([`'\""
nnoremap <silent><A-C-b> :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>
nnoremap <silent><A-C-f> :<C-u>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>
inoremap <silent><A-C-b> <C-o>:call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>
inoremap <silent><A-C-f> <C-o>:call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>
vnoremap <silent><A-C-b> :<C-U>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%^','bW')<CR>v`>o
vnoremap <silent><A-C-f> <Esc>`>:<C-U>call search('\C\<\<Bar>\%(^\<Bar>[^'.g:camelchar.']\@<=\)['.g:camelchar.']\<Bar>['.g:camelchar.']\ze\%([^'.g:camelchar.']\&\>\@!\)\<Bar>\%$','W')<CR>v`<o
endif

nnoremap n nzz
nnoremap N Nzz
nnoremap Q gqap
nnoremap ZA :xa<CR>

" Use <C-x><C-o> to activate vim omnicompletion
" iunmap <C-x><C-o>

" https://github.com/junegunn/fzf.vim/issues/865
" https://github.com/junegunn/fzf.vim/issues/10
" TODO a for :args
" TODO c for :changes
" TODO j for :jumps
" TODO p for put into register
" TODO P for append to register
" TODO y for yank from register
" TODO @ for execute macro from registers
nnoremap <silent> <leader>' :Marks!<CR>
nnoremap <silent> <leader>/ :History/!<CR>
nnoremap <silent> <leader>: :History:!<CR>
nnoremap <silent> <leader>? :Helptags!<CR>
nnoremap <silent> <leader>A :Ag!<CR>
" use gb instead
" nnoremap <silent> <leader>b :Buffers!<CR>
" nnoremap <silent> <leader>c :Commits!<CR>
nnoremap <silent> <leader>C :BCommits!<CR>
" nnoremap <silent> <leader>f :Files!<CR>
nnoremap <silent> <leader>F :Filetypes!<CR>
" nnoremap <silent> <leader>gf :GFiles!<CR>
nnoremap <silent> <leader>h :History!<CR>
" nnoremap <silent> <leader>l :Lines!<CR>
nnoremap <silent> <leader>L :BLines!<CR>
nnoremap <silent> <leader>m :Maps!<CR>
nnoremap <silent> <leader>r :Rg!<CR>
" nnoremap <silent> <leader>s :Snippets!<CR>
" nnoremap <silent> <leader>t :Tags!<CR>
nnoremap <silent> <leader>T :BTags!<CR>
" nnoremap <silent> <leader>w :Windows!<CR>
nnoremap <silent> <leader>x :Commands!<CR>
nnoremap <silent> <leader>z :FZF! -m<CR>

" https://github.com/junegunn/fzf.vim#mappings
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" https://github.com/junegunn/fzf.vim#completion-functions
" Path completion with custom source command
inoremap <expr> <c-x><c-r> fzf#vim#complete#path('rg --files')
inoremap <expr> <c-x>r fzf#vim#complete#path('rg --files')
inoremap <expr> <c-x><c-d> fzf#vim#complete#path('exa --only-dirs')
inoremap <expr> <c-x>d fzf#vim#complete#path('exa --only-dirs')

" Mappings inspired by my .zshrc
imap <c-x><c-u> <C-o>u
imap <c-x>u <C-o>u
imap <c-x><c-x> <C-o>``
imap <c-x>x <C-o>``

nnoremap n nzz
nnoremap N Nzz
nnoremap Q gqap
nnoremap ZA :xa<CR>

nnoremap Y y$

if !has('nvim')
    set <A-s>=s
    set <A-S>=S
endif

" 2-character Sneak (default)
nmap <A-s>   <Plug>Sneak_s
nmap <A-S> <Plug>Sneak_S
" visual-mode
xmap <A-s>   <Plug>Sneak_s
xmap <A-S> <Plug>Sneak_S
" operator-pending-mode
omap <A-s>   <Plug>Sneak_s
omap <A-S> <Plug>Sneak_S

" repeat motion
map ; <Plug>Sneak_;
map , <Plug>Sneak_,

" 1-character enhanced 'f'
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
" visual-mode
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
" operator-pending-mode
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F

" 1-character enhanced 't'
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
" visual-mode
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
" operator-pending-mode
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

" https://vimrcfu.com/snippet/250
" https://vi.stackexchange.com/a/15785
function! ToggleHML()
    set scrolloff=0
    let l:last_win_line = ( line('$') <= winheight('%') ? line('$')  : winheight('%')  )
    if winline() == l:last_win_line / 2
      normal H
    elseif winline() == l:last_win_line
      normal M
    elseif winline() == 1
      normal L
    else
      normal M
    endif
endfunction

function! Toggleztzzzb()
    set scrolloff=0
    let l:last_win_line = ( line('$') <= winheight('%') ? line('$')  : winheight('%')  )
    if winline() == l:last_win_line / 2
      normal zt
    elseif winline() == l:last_win_line
      normal zz
    elseif winline() == 1
      normal zb
    else
      normal zz
    endif
endfunction

function! PutNumbers(...)
    let start     = get(a:, 1, 1)
    let stop      = get(a:, 2, 10)
    let format    = get(a:, 3, "%02d. \n")
    let delimiter = get(a:, 4, '')
    let prefix    = get(a:, 5, '')
    let suffix    = get(a:, 6, '')
    put=prefix.join(map(range(start,stop), 'printf(format, v:val)'), delimiter).suffix
endfunction

nnoremap <C-l> :call Toggleztzzzb()<CR>
nnoremap <M-r> :call ToggleHML()<CR>
inoremap <C-l> <C-o>:call Toggleztzzzb()<CR>
inoremap <M-r> <C-o>:call ToggleHML()<CR>

" https://github.com/SpaceVim/SpaceVim/issues/2260#issuecomment-482814306
" https://www.vim.org/scripts/script.php?script_id=300

function! <SID>LetDefault(var_name, value)
  if !exists(a:var_name)
    execute 'let ' . a:var_name . '=' . a:value
  endif
endfunction

function! <SID>Mark(...)
  if a:0 == 0
    let mark = line(".") . "G" . virtcol(".") . "|"
    normal! H
    let mark = "normal!" . line(".") . "Gzt" . mark
    execute mark
    return mark
  elseif a:0 == 1
    return "normal!" . a:1 . "G1|"
  else
    return "normal!" . a:1 . "G" . a:2 . "|"
  endif
endfun

function! <SID>StartSearch(search_dir)
  let s:incsearch_status = &incsearch
  let s:lazyredraw_status = &lazyredraw
  set incsearch
  cmap <C-c> <CR>
  cnoremap <C-s> <C-c><C-o>:call <SID>SearchAgain()<CR><C-o>/<Up>
  cnoremap <C-r> <C-c><C-o>:call <SID>SearchAgain()<CR><C-o>?<Up>
  cnoremap <silent> <CR> <CR><C-o>:call <SID>StopSearch()<CR>
  cnoremap <silent> <C-g> <C-c><C-o>:call <SID>AbortSearch()<CR>
  cnoremap <silent> <Esc> <C-c><C-o>:call <SID>AbortSearch()<CR>
  if a:search_dir == '/'
    cnoremap <M-s> <CR><C-o>:set invhls<CR><Left><C-o>/<Up>
  else
    cnoremap <M-s> <CR><C-o>:set invhls<CR><Left><C-o>?<Up>
  endif
  let s:before_search_mark = <SID>Mark()
endfunction

function! <SID>StopSearch()
  cunmap <C-c>
  cunmap <C-s>
  cunmap <C-r>
  cunmap <CR>
  cunmap <C-g>
  cnoremap <C-g> <C-c>
  if exists("s:incsearch_status")
    let &incsearch = s:incsearch_status
    unlet s:incsearch_status
  endif
  if g:VM_SearchRepeatHighlight == 1
    if exists("s:hls_status")
      let &hls = s:hls_status
      unlet s:hls_status
    endif
  endif
endfunction

function! <SID>AbortSearch()
  call <SID>StopSearch()
  if exists("s:before_search_mark")
    execute s:before_search_mark
    unlet s:before_search_mark
  endif
endfunction

function! <SID>SearchAgain()
  if (winline() <= 2)
    normal zb
  elseif (( winheight(0) - winline() ) <= 2)
    normal zt
  endif
  cnoremap <C-s> <CR><C-o>:call <SID>SearchAgain()<CR><C-o>/<Up>
  cnoremap <C-r> <CR><C-o>:call <SID>SearchAgain()<CR><C-o>?<Up>
  if g:VM_SearchRepeatHighlight == 1
    if !exists("s:hls_status")
      let s:hls_status = &hls
    endif
    set hls
  endif
endfunction

" Emacs' `query-replace' functions

function! <SID>QueryReplace()
  let magic_status = &magic
  set nomagic
  let searchtext = input("Query replace: ")
  if searchtext == ""
    echo "(no text entered): exiting to Insert mode"
    return
  endif
  let replacetext = input("Query replace " . searchtext . " with: ")
  let searchtext_esc = escape(searchtext,'/\^$')
  let replacetext_esc = escape(replacetext,'/\')
  execute ".,$s/" . searchtext_esc . "/" . replacetext_esc . "/cg"
  let &magic = magic_status
endfunction

function! <SID>QueryReplaceRegexp()
  let searchtext = input("Query replace regexp: ")
  if searchtext == ""
    echo "(no text entered): exiting to Insert mode"
    return
  endif
  let replacetext = input("Query replace regexp " . searchtext . " with: ")
  let searchtext_esc = escape(searchtext,'/')
  let replacetext_esc = escape(replacetext,'/')
  execute ".,$s/" . searchtext_esc . "/" . replacetext_esc . "/cg"
endfunction

command! QueryReplace :call <SID>QueryReplace()<CR>
command! QueryReplaceRegexp :call <SID>QueryReplaceRegexp()<CR>

function! <SID>GotoLine()
  let targetline = input("Goto line: ")
  if targetline =~ "^\\d\\+$"
    execute "normal! " . targetline . "G0"
  elseif targetline =~ "^\\d\\+%$"
    execute "normal! " . targetline . "%"
  elseif targetline == ""
    echo "(cancelled)"
  else
    echo " <- Not a Number"
  endif
endfunction

command! GotoLine :call <SID>GotoLine()

function! <SID>YankPop()
  undo
  if !exists("s:kill_ring_position")
    call <SID>ResetKillRing()
  endif
  execute "normal! i\<C-r>\<C-o>" . s:kill_ring_position . "\<Esc>"
  call <SID>IncrKillRing()
endfunction

function! <SID>ResetKillRing()
  let s:kill_ring_position = 3
endfunction

function! <SID>IncrKillRing()
  if s:kill_ring_position >= 9
    let s:kill_ring_position = 2
  else
    let s:kill_ring_position = s:kill_ring_position + 1
  endif
endfunction

function! <SID>StartMarkSel()
  if &selectmode =~ 'key'
    set keymodel-=stopsel
  endif
endfunction

function! <SID>StartVisualMode()
  call <SID>StartMarkSel()
  if col('.') > strlen(getline('.'))
    " At EOL
    return "\<Right>\<C-o>v\<Left>"
  else
    return "\<C-o>v"
  endif
endfunction

function! <SID>number_of_windows()
  let i = 1
  while winbufnr(i) != -1
    let i = i + 1
  endwhile
  return i - 1
endfunction

function! <SID>FindFileOtherWindow(filename)
  let num_windows = <SID>number_of_windows()
  if num_windows <= 1
    wincmd s
  endif
  wincmd w
  execute "edit " . a:filename
  wincmd W
endfunction

command! -nargs=1 -complete=file FindFileOtherWindow :call <SID>FindFileOtherWindow(<f-args>)

command! ScrollOtherWindow silent! execute "normal! \<C-w>w\<PageDown>\<C-w>W"

command! FillParagraph :call <SID>FillParagraph()

function! <SID>FillParagraph()
  let old_cursor_pos = <SID>Mark()
  normal! gqip
  execute old_cursor_pos
endfunction

function! <SID>DeleteBlankLines()
  if getline(".") == "" || getline(". + 1") == "" || getline(". - 1") == ""
    ?^.\+$?+1,/^.\+$/-2d"_"
  endif
  normal j
endfunction

command! PointToRegister :call PointToRegister()
command! JumpToRegister :call JumpToRegister()

function! <SID>PointToRegister()
  echo "Point to mark: "
  let c = nr2char(getchar())
  execute "normal! m" . c
endfunction

function! <SID>JumpToRegister()
  echo "Jump to mark: "
  let c = nr2char(getchar())
  execute "normal! `" . c
endfunction

if !has('nvim')
    set <M-1>=1
    set <M-2>=2
    set <M-3>=3
    set <M-4>=4
    set <M-5>=5
    set <M-6>=6
    set <M-7>=7
    set <M-8>=8
    set <M-9>=9
    set <M-0>=0
    set <M-a>=a
    set <M-b>=b
    set <M-c>=c
    set <M-d>=d
    set <M-e>=e
    set <M-f>=f
    set <M-g>=g
    set <M-h>=h
    set <M-i>=i
    set <M-j>=j
    set <M-k>=k
    set <M-l>=l
    set <M-m>=m
    set <M-n>=n
    set <M-o>=o
    set <M-p>=p
    set <M-q>=q
    set <M-r>=r
    set <M-s>=s
    set <M-t>=t
    set <M-u>=u
    set <M-v>=v
    set <M-w>=w
    set <M-x>=x
    set <M-y>=y
    set <M-z>=z
    set <M->=
    set <M-/>=/
    set <Char-190>=>
    set <Char-188>=<
    set <M-<>=<
    set <M-0>=0
    set <M-%>=%
    set <M-*>=*
    set <M-.>=.
    set <M-^>=^
endif

unmap ,<space>

if has('nvim')
  au TextYankPost * silent! lua vim.highlight.on_yank()
elseif !exists('##TextYankPost')
  nmap y <Plug>(highlightedyank)
  xmap y <Plug>(highlightedyank)
  omap y <Plug>(highlightedyank)
endif

set sel=exclusive
endfunction
