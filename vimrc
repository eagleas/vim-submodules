" Bundle all plugins
set runtimepath+=$HOME/.vim/bundle/vim-pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

set nowrap      "dont wrap lines
set linebreak   "wrap lines at convenient points

"statusline setup
set statusline=%f       "tail of the filename

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%{StatuslineLongLineWarning()}

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

" Tabs and spaces indent
set nu
set sw=2
set sts=2
set expandtab
set autoindent

set mousetime=750

colorscheme wombat

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

"display tabs and trailing spaces
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"load ftplugins and indent files
filetype plugin on
filetype indent on

"turn on syntax highlighting
syntax on

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

"tell the term has 256 colors
set t_Co=256

"hide buffers when not displayed
set hidden

"dont load csapprox if we no gui support - silences an annoying warning
if !has("gui")
    let g:CSApprox_loaded = 1
endif



"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map to bufexplorer
nnoremap <C-B> :BufExplorer<cr>

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

" Display files navigator "\ + p"
nmap <silent> <Leader>p :NERDTreeToggle<CR>

" Ctrl-S is save
map <C-S> :w<CR>
imap <C-S> <C-O>:w<CR>
cmap <C-S> <C-C>:w<CR>

" U in Visual mode Upper-Case
vmap <C-U> gU

" L in Visual mode Lower-Case
vmap <C-L> gu

" Alt-a open all buffers in their own tabs
map <M-a> :tab ball<CR>
imap <M-a> <C-O>:tab ball<CR>
cmap <M-a> <C-C>:tab ball<CR>

" Ctrl-Tab goes to next window tab
map <C-RIGHT> :tabnext<CR>
imap <C-RIGHT> <C-O>:tabnext<CR>
cmap <C-RIGHT> <C-C>:tabnext<CR>

autocmd VimLeavePre * nested execute "NERDTreeClose"
" Save session before exit
autocmd VimLeave * nested execute "mksession! " . $HOME . "/.vim_session"
" autocmd VimEnter * nested if argc() == 0 | execute "source " . $HOME . "/.vim_session"

" Load laest session
map <F3> :source ~/.vim_session <cr>

" Sudo saving
cmap w!! %!sudo tee > /dev/null %

"mark syntax errors with :signs
let g:syntastic_enable_signs=1

" Rsense
let g:rsenseHome = "$RSENSE_HOME"
let g:rsenseUseOmniFunc = 1

"Ack grep
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

"Insert copy pasted text without auto indent
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>

"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>


let g:browser = 'xdg-open '

" remember folds
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview

" Tags setup
set tags=tags;/
" Invoke :Rtags will refresh tags with this arguments
let g:rails_ctags_arguments = "~/.rvm/gems/ruby-1.9.2-p0 ~/work"

set winminheight=0      " Allow windows to get fully squashed
"
" Switch between windows, maximizing the current window
"
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_


" Tag list plugin setup
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Exit_OnlyWindow = 1     " exit if taglist is last window open
let Tlist_Show_One_File = 1       " Only show tags for current buffer
let Tlist_Enable_Fold_Column = 0  " no fold column (only showing one file)
let tlist_sql_settings = 'sql;P:package;t:table'
let tlist_ant_settings = 'ant;p:Project;r:Property;t:Target'
let Tlist_Use_Right_Window = 1


"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"define :HighlightLongLines command to highlight the offending parts of
"lines that are longer than the specified length (defaulting to 80)
command! -nargs=? HighlightLongLines call s:HighlightLongLines('<args>')
function! s:HighlightLongLines(width)
    let targetWidth = a:width != '' ? a:width : 79
    if targetWidth > 0
        exec 'match Todo /\%>' . (targetWidth) . 'v/'
    else
        echomsg "Usage: HighlightLongLines [natural number]"
    endif
endfunction

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction


"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
    return b:statusline_tab_warning
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")
        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)

    let long_line_lens = []

    let i = 1
    while i <= line("$")
        let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
        if len > threshold
            call add(long_line_lens, len)
        endif
        let i += 1
    endwhile

    return long_line_lens
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction

" === BEGIN Moving lines "Ctrl + Arrows(ex. Up, Down)"
function! MoveLineUp()
  call MoveLineOrVisualUp(".", "")
endfunction
function! MoveLineDown()
  call MoveLineOrVisualDown(".", "")
endfunction
function! MoveVisualUp()
  call MoveLineOrVisualUp("'<", "'<,'>")
  normal gv
endfunction
function! MoveVisualDown()
  call MoveLineOrVisualDown("'>", "'<,'>")
  normal gv
endfunction
function! MoveLineOrVisualUp(line_getter, range)
  let l_num = line(a:line_getter)
  if l_num - v:count1 - 1 < 0
    let move_arg = "0"
  else
    let move_arg = a:line_getter." -".(v:count1 + 1)
  endif
  call MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
endfunction
function! MoveLineOrVisualDown(line_getter, range)
  let l_num = line(a:line_getter)
  if l_num + v:count1 > line("$")
    let move_arg = "$"
  else
    let move_arg = a:line_getter." +".v:count1
  endif
  call MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
endfunction
function! MoveLineOrVisualUpOrDown(move_arg)
  let col_num = virtcol(".")
  execute "silent! ".a:move_arg
  execute "normal! ".col_num."|"
endfunction
nnoremap <silent> <C-Up> :<C-u>call MoveLineUp()<CR>
nnoremap <silent> <C-Down> :<C-u>call MoveLineDown()<CR>
inoremap <silent> <C-Up> <C-o>:<C-u>call MoveLineUp()<CR>
inoremap <silent> <C-Down> <C-o>:<C-u>call MoveLineDown()<CR>
vnoremap <silent> <C-Up> :<C-u>call MoveVisualUp()<CR>
vnoremap <silent> <C-Down> :<C-u>call MoveVisualDown()<CR>
" === END Moving Lines

au FileType * if &ft == 'eruby' | call SetupSnips(snippets_dir, 'html', 'eruby') | endif
" Setup ruby snips
fun! SetupSnips(dir, aliasft, realft)
  for path in split(globpath(a:dir, a:aliasft.'/')."\n".
      \ globpath(a:dir, a:aliasft.'-*/'), "\n")
    if has_key(g:did_ft, a:aliasft.'.'.a:realft) | continue | endif
    call ExtractSnips(path, a:realft)
  endfor
  for path in split(globpath(a:dir, a:aliasft.'.snippets')."\n".
      \ globpath(a:dir, a:aliasft.'-*.snippets'), "\n")
    if has_key(g:did_ft, a:aliasft.'.'.a:realft) | continue | endif
    call ExtractSnipsFile(path, a:realft)
  endfor
  let g:did_ft[a:aliasft.'.'.a:realft] = 1
endf


"Russian keymaps setup http://ru.wikibooks.org/wiki/Vim
"set keymap=russian-jcukenwin
"set iminsert=0
"imap <F12> {ctrl-k}{ctrl-6}{ctrl-6}
set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl;'zxcvbnm,.~QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>

"Russian translation
let g:from_language='en'
let g:to_language='ru'
nnoremap <Space> :Trans<CR>
nnoremap <Leader><Space> :TransReverse<CR>
vnoremap <Space> <ESC>:TransV<CR>
vnoremap <Leader><Space> <ESC>:TransVReverse<CR>


command! -nargs=0 -range SortWords call SortWords()
" Add a mapping, go to your string, then press vi",s
" vi" selects everything inside the quotation
" ,s calls the sorting algorithm
vmap ,s :SortWords<CR>
" Normal mode one: ,s to select the string and sort it
nmap ,s vi",s
function! SortWords()
    " Get the visual mark points
    let StartPosition = getpos("'<")
    let EndPosition = getpos("'>")

    if StartPosition[0] != EndPosition[0]
        echoerr "Range spans multiple buffers"
    elseif StartPosition[1] != EndPosition[1]
        " This is a multiple line range, probably easiest to work line wise

        " This could be made a lot more complicated and sort the whole
        " lot, but that would require thoughts on how many
        " words/characters on each line, so that can be an exercise for
        " the reader!
        for LineNum in range(StartPosition[1], EndPosition[1])
            call setline(LineNum, join(sort(split(getline('.'), ' ')), " "))
        endfor
    else
        " Single line range, sort words
        let CurrentLine = getline(StartPosition[1])

        " Split the line into the prefix, the selected bit and the suffix

        " The start bit
        if StartPosition[2] > 1
            let StartOfLine = CurrentLine[:StartPosition[2]-2]
        else
            let StartOfLine = ""
        endif
        " The end bit
        if EndPosition[2] < len(CurrentLine)
            let EndOfLine = CurrentLine[EndPosition[2]:]
        else
            let EndOfLine = ""
        endif
        " The middle bit
        let BitToSort = CurrentLine[StartPosition[2]-1:EndPosition[2]-1]

        " Move spaces at the start of the section to variable StartOfLine
        while BitToSort[0] == ' '
            let BitToSort = BitToSort[1:]
            let StartOfLine .= ' '
        endwhile
        " Move spaces at the end of the section to variable EndOfLine
        while BitToSort[len(BitToSort)-1] == ' '
            let BitToSort = BitToSort[:len(BitToSort)-2]
            let EndOfLine = ' ' . EndOfLine
        endwhile

        " Sort the middle bit
        let Sorted = join(sort(split(BitToSort, ' ')), ' ')
        " Reform the line
        let NewLine = StartOfLine . Sorted . EndOfLine
        " Write it out
        call setline(StartPosition[1], NewLine)
    endif
endfunction
