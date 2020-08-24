
"TODO : Open terminal in split above rather than below, everywhere
"     : add <F12> and ctrl<F12> keys to pull template or something
" learn omni functions and ultisnip plugin later, Also multicursor may work try again later
"
" Configure webd - pull template, emmet, tagalong, vim-surround, deoplete
" setup


"Apr1  - Added template pull commands and Tab movements
"Apr16 - Added NEW and NEWN commands to make new files by timestamp
"Apr 27 - changed build and debug commands to have c++17 standard and -O2,
"         added rainbow colours and multi cursor
"Apr 29 - Restructured and expanded Build,Run,Debug commands.
"         Now no need to put if #define ONLINE_JUDGE in cpp
"         Also, added .gdbinit_apr with this
"       Building
"         <F7>, build results in split terminal
"       
"       Running 
"         ctrl <F9> 2s time, file to file
"         <F8> no timeout, terminal to terminal
"         <F9> 0.2s time, file to file
"       
"       Debugging
"         ctrl <F8>, new tab debugging, file or no file can
"               be typed on own by r < input.txt or not
"May 2 - Added RunJava Command
"
"May 8 - Added run pipeline, adding keymaps for this pipeline to <F6>,
"ctrl<F6> and ctrl<F7>  
"
"May 22 - Stopped multicursor, rather learn to use vim commands, and make one
"for yourself maybe. AND added automatically select first in the deoplete.
"
"May 31 - deoplete setup - changed mark names, source rankings, candidate keys
"also made commands like :Wa :Qa :Wqa do what they are supposed to
"
"June 10 - added :W and :WA commands. Added template pull for HTML,CSS,JS.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')

    "Autocompletion with deoplete
    if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/deoplete.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif
    Plug 'deoplete-plugins/deoplete-jedi'
    "For c++
    Plug 'Shougo/deoplete-clangx'

    "Themes
    Plug 'kyoz/purify', { 'rtp': 'vim' }   "Vibrant colours on pure black
    Plug 'jonathanfilip/vim-lucius'    "Light colours on dark, dark number gutter
    Plug 'owickstrom/vim-colors-paramount'   "LessColour on Black
    Plug 'nanotech/jellybeans.vim'  "More Colour on dark
    Plug 'morhetz/gruvbox'    "Orangish

    "That line at the bottom
    Plug 'vim-airline/vim-airline'

    "Copy and Paste accross programs
    Plug 'christoomey/vim-system-copy'

    "Syntax checker.
    Plug 'vim-syntastic/syntastic'

    "Start screen
    Plug 'mhinz/vim-startify'

    "File browsing within vim
    Plug 'preservim/nerdtree'

    "Colour them brackets!
    Plug 'luochen1990/rainbow'   

    "Plug 'terryma/vim-multiple-cursors'
    "This was creating problems with autocompletion after latest update to
    "neovim as it was automatically inserting values

call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:deoplete#enable_at_startup = 1

"match lower to upper too
call deoplete#custom#option('camel_case', v:true)
"when upper included, match upper to upper only
call deoplete#custom#option('smart_case', v:true)
"delay of 400 ms
call deoplete#custom#option('auto_complete_delay', 400)

set completeopt=menu,menuone,preview,noinsert
set complete=.,w,b,u,i,d,t

"One key press completion
call deoplete#custom#option('candidate_marks',
      \ ['1', '2', '3', '4', '5'])
inoremap <expr>1       pumvisible() ?
\ deoplete#insert_candidate(0) : '1'
inoremap <expr>2       pumvisible() ?
\ deoplete#insert_candidate(1) : '2'
inoremap <expr>3       pumvisible() ?
\ deoplete#insert_candidate(2) : '3'
inoremap <expr>4       pumvisible() ?
\ deoplete#insert_candidate(3) : '4'
inoremap <expr>5       pumvisible() ?
\ deoplete#insert_candidate(4) : '5'

"call deoplete#custom#option('jedi', 'is_debug_enabled', 1)
"call deoplete#enable_logging('DEBUG', 'deoplete.log')
"call deoplete#custom#option('profile', v:true)
"call deoplete#custom#source('deoplete-clangx', 'is_debug_enabled', 1)

"Level to appear in pop up menu
call deoplete#custom#source('omni','rank',700)
call deoplete#custom#source('around','rank',500)
call deoplete#custom#source('file','rank', 350)
call deoplete#custom#source('buffer','rank',200)
call deoplete#custom#source('member','rank',200)
call deoplete#custom#source('clangx', 'rank', 100)

"Length of word to be typed before searching.
call deoplete#custom#source('omni','min_pattern_length',4)
call deoplete#custom#source('around','min_pattern_length',3)
call deoplete#custom#source('file','min_pattern_length', 4)
call deoplete#custom#source('buffer','min_pattern_length',4)
call deoplete#custom#source('member', 'min_pattern_length', 4)
call deoplete#custom#source('clangx', 'min_pattern_length', 4)

"Change what displays for their names.
call deoplete#custom#source('omni', 'mark', '[om]')
call deoplete#custom#source('around', 'mark', '[ar]')
call deoplete#custom#source('file','mark', '[fl]')
call deoplete#custom#source('buffer','mark', '[bf]')
call deoplete#custom#source('member', 'mark', '[mb]')
call deoplete#custom#source('clangx', 'mark', '[cx]')

"Range of around and symbols.
call deoplete#custom#var('around', {
\   'range_above': 50,
\   'range_below': 50,
\   'mark_above': '[↑]',
\   'mark_below': '[↓]',
\   'mark_changes': '[*]',
\})


"check :help deoplete-faq
"check :help deoplete-sources

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on

"Close preview window on going to insert mode, or even completing the autocomplete
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif
"This closes only when you press escape(i.e. when you leave insert mode)
autocmd InsertLeave * if pumvisible() == 0 | silent! pclose | endif

"Some Graphics
set termguicolors  "Uses 256colors, first used in vim-archery. Now
		   "I use it in every colorscheme
set background=dark  "Many colorschemes automatically change, namely gruvbox, lucius, paramount
"their modes acc to this. dark or light
colorscheme jellybeans
" Lucius<Dark/Black/Light/White><null/HighContrast/LowContrast>
" This is lucius use template. Just put whatever you
" want after setting colorscheme lucius
" like as given below, just write that and it will work
"LuciusLightHighContrast

"gruvbox specific
" let g:gruvbox_ = ''   "TEMPLATE
"let g:gruvbox_bold = '1'
"let g:gruvbox_italic = '1'
"let g:gruvbox_underline = '1'
"let g:gruvbox_contrast_dark = 'hard'
"let g:gruvbox_italicize_strings = '1'

"set showtabline=2  "TABS on top, like chrome
"set laststatus=2   "Statusline at bottom, default in nvim


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Following set of lines is for syntastic plugin
" THese three lines are off for now, maybe they'll work well with airline or
" something
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
""validator was preinstalled in my laptop
let g:syntastic_html_checkers = ['validator']
""Install NodeJS, npm and then ESlint globally. Then do
"    "eslint --init to start
let g:syntastic_javascript_checkers = ['eslint']


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"OLDVIMRC COMMENT - latest addition on aug31/2019. It might not be on PC and GDrive backups of
"vimrc.
"These lines of code help by remembering the fold or unfolded state of code
augroup remember_folds
 autocmd!
 au BufWinLeave ?* mkview 1
 au BufWinEnter ?* silent! loadview 1
augroup END

""""TABS AND SPACES
set tabstop=4   "number of visual spaces per tab
set softtabstop=4   "no of spaces in tab when editing
set expandtab 		"tabs are spaces
set shiftwidth=4

""""GRAPHICAL
set number
set showcmd
set noequalalways "This doesn't change window size automatically when opening or closing windows
"""" Enable CursorLine
set cursorline
"""" Default Colors for CursorLine
highlight  CursorLine ctermbg=234 ctermfg=None
" Change Color when entering Insert Mode
autocmd InsertEnter * highlight  CursorLine ctermbg=238 ctermfg=None
" Revert Color to default when leaving Insert Mode
autocmd InsertLeave * highlight  CursorLine ctermbg=234 ctermfg=None
set wildmenu
set lazyredraw
set showmatch
filetype indent on

"TABS
"Changed this from map to noremap on Feb8_2020
noremap <C-l> :tabn<cr>
noremap <C-h> :tabp<cr>

"Added this Apr6_2020
"This makes pressing Tab in normal mode to switch windows
nnoremap <Tab> <C-w>w   

"nnoremap <S-Tab> :tabn<cr>   
"Above line works perfectly but not using RN

"SEARCHING
set incsearch
set hlsearch
noremap <leader><space> :nohlsearch<CR>

"FOLDING
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds
noremap <space> za
set foldmethod=indent   " fold based on indent level

"MOVEMENT
" move vertically by visual line
noremap j gj
noremap k gk

"Tried to achieve the following line's effect, but instead had to turn off
"curly bracket highlighting
"syn clear cErrInBracket
let c_no_curly_error = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUN THIS FIRST sudo apt-get install fonts-powerline
" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Startify stuff
let g:startify_bookmarks = ['~/.config/nvim/init.vim']  "A list of files or directories to bookmark.
let g:startify_change_to_dir = 1
let g:startify_update_oldfiles = 0  "Update startify on-the-fly, not only on exit
let g:startify_custom_header = 'startify#center(startify#fortune#cowsay())'
autocmd VimEnter *
            \   if !argc()
            \ |   Startify
            \ |   NERDTree
            \ |   wincmd w
            \ | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"RAINBOW CONFIGURATIONS
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Multi cursor configs and uses

"Instructions and Readme, not code
"start: <C-n> start multicursor and add a virtual cursor + selection on the match
"next: <C-n> add a new virtual cursor + selection on the next match
"skip: <C-x> skip the next match
"prev: <C-p> remove current virtual cursor + selection and go back on previous match
"select all: <A-n> start multicursor and directly select all matches
"You can now change the virtual cursors + selection with visual mode commands. 
"For instance: c, s, I, A work without any issues. You could also go to normal mode by 
"pressing v and use normal commands there.
"
"At any time, you can press <Esc> to exit back to regular Vim.
"
"start with g<C-n> to match without boundaries (behaves like g* instead of *)

"visual mode when multiple lines are selected
"start: <C-n> add virtual cursors on each line
"You can now change the virtual cursors with normal mode commands. For instance: ciw


""If deoplete was enabled, disable for a sec
"func! Multiple_cursors_before()
"  if deoplete#is_enabled()
"    call deoplete#disable()
"    let g:deoplete_is_enable_before_multi_cursors = 1
"  else
"    let g:deoplete_is_enable_before_multi_cursors = 0
"  endif
"endfunc
"
"
"
""Then enable again
"func! Multiple_cursors_after()
"  if g:deoplete_is_enable_before_multi_cursors
"    call deoplete#enable()
"  endif
"endfunc


"RATHER TRY THIS LATER ON
"function g:Multiple_cursors_before()
"	  call deoplete#custom#buffer_option('auto_complete', v:false)
"	endfunction
"	function g:Multiple_cursors_after()
"	  call deoplete#custom#buffer_option('auto_complete', v:true)
"	endfunction



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"My Own additions


" only f10 and f11 cant be used
" 
" debug -> in new terminal tab
" in tui after opening a new terminal
" 
" build -> simple one command   (popup terminal)              
" 
" run -> file to file           (timeout 2s)    (code 1)
"     -> terminal to terminal   (no timeout)    (code 2) (in split terminal)
"     -> file to file           (timeout 0.2s)  (code 3)
"
" pipeline -> generator to result  (timeout 1s for each file) (code 1)
"          -> input.txt to result  (timeout 1s for each file) (code 2)

function Debug_soln()
    :wa
    :tabnew | terminal
    ":belowright split | terminal
    :call jobsend(b:terminal_job_id, "g++ -g -Og -Wall -Wextra -pedantic-errors -std=c++17 soln.cpp\n")
    :call jobsend(b:terminal_job_id, "gdb ./a.out -tui\n")
    :exe "normal a" 
    "This above line to go to last input box of terminal
endfunction

function Build_soln()
    :wa
    :! g++ -O2 -Wall -Wextra -pedantic-errors -std=c++17 soln.cpp
    "-g and -Og not set as we are not debugging
    " There is a problem that it goes to first line after build.
    "Following line, to go to last line doesn't work 
    ":exe "normal G"
endfunction

function Run_soln(code)
    :silent exec Build_soln()
    if a:code == 1
        ":! ./a.out
        :silent ! ./a.out < input.txt > output.txt & sleep 2s && kill $(jobs -p)
    elseif a:code == 2
        :belowright split | terminal
        :call jobsend(b:terminal_job_id, "./a.out \n")
        :exe "normal a" 
    elseif a:code == 3
        :silent ! ./a.out < input.txt > output.txt & sleep 0.2s && kill $(jobs -p)
        "Test this once
    else
        :silent ! ./a.out < ginput.txt > output.txt & sleep 1s && kill $(jobs -p)
    endif

    "You can even route some other program's output to ./a.out, like
    "./a.out < ./m.out > output.txt
endfunction

"working fine
function Run_generator()
    :wa
    :! g++ -O2 -Wall -Wextra -pedantic-errors -std=c++17 generator.cpp -o generator.out
    :silent ! ./generator.out > ginput.txt & sleep 1s && kill $(jobs -p)
endfunction

"working fine
function Run_csoln(code)
    :wa
    if a:code == 1
        :! g++ -O2 -Wall -Wextra -pedantic-errors -std=c++17 csoln.cpp -o csoln.out
        :silent ! ./csoln.out < ginput.txt > coutput.txt & sleep 1s && kill $(jobs -p)
    else
        :! g++ -O2 -Wall -Wextra -pedantic-errors -std=c++17 csoln.cpp -o csoln.out
        :silent ! ./csoln.out < input.txt > coutput.txt & sleep 1s && kill $(jobs -p)
    endif
endfunction

"working fine
function Run_checker(code)
    :wa
    if a:code == 1
        :! g++ -O2 -Wall -Wextra -pedantic-errors -std=c++17 checker.cpp -o checker.out
        :silent ! ./checker.out ginput.txt > result.txt & sleep 1s && kill $(jobs -p)
    else
        :! g++ -O2 -Wall -Wextra -pedantic-errors -std=c++17 checker.cpp -o checker.out
        :silent ! ./checker.out input.txt > result.txt & sleep 1s && kill $(jobs -p)
    endif
endfunction

"working fine
function Run_pipeline(code)
    :wa
    if a:code == 1
        :exec Run_generator()
        ""Run generator
        ":! g++ -O2 -Wall -Wextra -pedantic-errors -std=c++17 generator.cpp -o generator.out
        ":silent ! ./generator.out > ginput.txt & sleep 1s && kill $(jobs -p)

        :exec Run_soln(4)
        "Run my soln
        ":! g++ -O2 -Wall -Wextra -pedantic-errors -std=c++17 soln.cpp
        ":silent ! ./a.out < ginput.txt > output.txt & sleep 1s && kill $(jobs -p)

        :exec Run_csoln(1)
        ""Run brute force
        ":! g++ -O2 -Wall -Wextra -pedantic-errors -std=c++17 csoln.cpp -o csoln.out
        ":silent ! ./csoln.out < ginput.txt > coutput.txt & sleep 1s && kill $(jobs -p)

        :exec Run_checker(1)
        ""Run checker
        ":! g++ -O2 -Wall -Wextra -pedantic-errors -std=c++17 checker.cpp -o checker.out
        ":silent ! ./checker.out ginput.txt > result.txt & sleep 1s && kill $(jobs -p)
    else
        :exec Run_soln(1)
        "Run my soln
        ":! g++ -O2 -Wall -Wextra -pedantic-errors -std=c++17 soln.cpp
        ":silent ! ./a.out < ginput.txt > output.txt & sleep 1s && kill $(jobs -p)

        :exec Run_csoln(2)
        ""Run brute force
        ":! g++ -O2 -Wall -Wextra -pedantic-errors -std=c++17 csoln.cpp -o csoln.out
        ":silent ! ./csoln.out < input.txt > coutput.txt & sleep 1s && kill $(jobs -p)

        :exec Run_checker(2)
        ""Run checker
        ":! g++ -O2 -Wall -Wextra -pedantic-errors -std=c++17 checker.cpp -o checker.out
        ":silent ! ./checker.out input.txt > result.txt & sleep 1s && kill $(jobs -p)
    endif
endfunction

""Custom commands
command Debug  :exec Debug_soln()
command Build  :exec Build_soln()
command Run1   :exec Run_soln(1)
command Run2   :exec Run_soln(2)
command Run3   :exec Run_soln(3)
command Run4   :exec Run_soln(4)
command Runp1  :exec Run_pipeline(1)
command Runp2  :exec Run_pipeline(2)

" all mode no recursive remap of f9 and f8 and f7
" <F31> this is ctrl <F7>,  it is not being used right now
" map <F6> and <F30> to cp_pipelines.
" cp_pipeline -> run gen and put its output in ginput
" then run soln.cpp on ginput.txt and put to output.txt
" and run csoln.cpp on ginput.txt and put to coutput.txt
" then run checker on output.txt and coutput.txt and print to result.txt
" <F6> will run generator and whole pipeline
" <F30> will not run gen, instead it will use input.txt instead of ginput.txt

noremap <F32> :Debug<CR>
noremap <F7>  :Build<CR>
noremap <F33> :Run1<CR>
noremap <F8>  :Run2<CR>
noremap <F9>  :Run3<CR>
noremap <F31> :Run4<CR>
noremap <F6>  :Runp1<CR>
noremap <F30> :Runp2<CR>



"F9 -> Run soln.cpp from input to output, time limit 0.2sec
"
"Ctrl F9 -> Run soln.cpp from input to output, time limit 2sec
"
"F8 -> Run soln.cpp in new terminal window (user gives input, infinite time, manual break possible)
"
"Ctrl F8 -> Run visual debugger in new tab
"
"F7 -> Only compile and display the result
"
"Ctrl F7 -> Run soln.cpp on ginput.txt and print to output.txt (time limit 1s) (input generator is not run)
"THIS KEY CAN BE REMAPPED, NOT USED MUCH, JUST FOR SPACE FILLING
"
"F6 -> Run input generator to make input file. Run soln.cpp and brute.cpp on this generated input. Then run checker to compare the two outputs and display the difference in result.txt
"
"Ctrl F6 -> Run soln.cpp and brute.cpp on input.txt, and then checker finds the difference and puts in result.txt   (basically, do not run input generator. )

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"JAVA JAVA JAVA HADIPPA

function Run_Java()
    : wa | ! javac soln.java && java soln 
endfunction

command RunJava :exec Run_Java()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function Template_Cpp()
    :0  "Not deleting anything in this command to avoid accidental deletion
    :r ~/Documents/cp/nglib/TEMPLATE.cpp
endfunction

function Pull_Maths_Cpp()
    "pull at cursor
    ":0  "Not deleting anything in this command to avoid accidental deletion
    :r ~/Documents/cp/nglib/MATHS.cpp
endfunction

function Pull_Algos_Cpp()
    "pull at cursor
    ":0  "Not deleting anything in this command to avoid accidental deletion
    :r ~/Documents/cp/nglib/ALGOS.cpp
endfunction

function Pull_All_Cpp()
    :0  "Not deleting anything in this command to avoid accidental deletion
    :r ~/Documents/cp/nglib/ALL.cpp
endfunction

function Pull_SpecialQuestions_Cpp()
    "pull at cursor
    ":0  "Not deleting anything in this command to avoid accidental deletion
    :r ~/Documents/cp/nglib/special/SPECIAL_ALGOS.cpp
endfunction

" not using original, just here for reference
function! SaveWithDT_original(filename) range
    let l:extension = '.' . fnamemodify( a:filename, ':e' )
    if len(l:extension) == 1
        let l:extension = '.txt'
    endif

    let l:filename = escape( fnamemodify(a:filename, ':r') . strftime("_%d_%m_%Y__%H_%M_%S") . l:extension, ' ' )

    execute "write " . l:filename
endfunction

function! SaveWithDT_Normal(...) range
    if a:0 == 0
        let l:filename1 = expand('%:t:r')
        let l:extension1 = '.' . expand('%:e')
        if len(l:extension1) == 1
            let l:extension1 = '.txt'
        endif

        let l:filenamesave1 = escape( expand('%:t:r') . strftime("_%d_%m_%Y__%H_%M_%S") . l:extension1, ' ' )

        execute "write " . l:filenamesave1
    else
        let l:filename2 = fnamemodify(a:1, ':r')
        let l:extension2 = '.' . fnamemodify( a:1, ':e' )
        if len(l:extension2) == 1
            let l:extension2 = '.txt'
        endif

        let l:filenamesave2 = escape(fnamemodify(a:1, ':r') . strftime("_%d_%m_%Y__%H_%M_%S") . l:extension2, ' ' )

        execute "write " . l:filenamesave2
    endif

    "Now that the file is saved, clear this file
    :exe "normal ggvG$d"
    " deletes from start to end of file
endfunction

function! SaveWithDT_Pull(...) range
    :call call(function("SaveWithDT_Normal"),a:000)
    " first call says to go to the function call()
    " the function call() takes two arguments, first the function name to call
    " and other the argument list
    " Pull template
    :call Template_Cpp()
endfunction

"Custom commands
"command NT    :NERDTree
command Template :exec Template_Cpp()
command PullMathsHere :exec Pull_Maths_Cpp()
command PullAlgosHere :exec Pull_Algos_Cpp()
command PullAllBeginning :exec Pull_All_Cpp()
command PullTemplateBeginning :exec Template_Cpp()
command PullSpecialQuestionsHere :exec Pull_SpecialQuestions_Cpp()

"These are handy for quicker closing.
command W   :w
command Wq  :wq
command WQ  :wq
command Wa  :wa
command WA  :wa
command Wqa :wqa 
command WQa :wqa
command WQA :wqa
command Qa  :qa 
command QA  :qa 
command Q   :q

" Save my code into new file
" command! -nargs=1 NEW call SaveWithDT( <q-args> )  "The original command
" from net, kept here for reference
"
" My modifications
command! -nargs=* NEW call SaveWithDT_Pull( <f-args> )  "NEW file saved, and template pull
command! -nargs=* NEWN call SaveWithDT_Normal( <f-args> ) "NEW file saved.
" -nargs=* means 0 or more args

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Terminal Management
if has('nvim')
    tnoremap <Esc> <C-\><C-n>       
    "tnoremap is terminal only non recursive mapping
    "similarly there are inoremap, vnoremap, nnoremap
endif
command STerm : belowright split | terminal
command VTerm : vsplit | terminal
command TTerm : tabnew | terminal

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"WEB DEVELOPMENT BABY

function Template_Html()
    :0  "Not deleting anything in this command to avoid accidental deletion
    :r ~/Documents/wd/nglib/HTML_TEMPLATE.html
endfunction

function Template_Javascript()
    :0  "Not deleting anything in this command to avoid accidental deletion
    :r ~/Documents/wd/nglib/JS_TEMPLATE.js
endfunction

function Template_Css()
    :0  "Not deleting anything in this command to avoid accidental deletion
    :r ~/Documents/wd/nglib/CSS_TEMPLATE.css
endfunction

command Htmltemplate :exec Template_Html()
command Jstemplate :exec Template_Javascript()
command Csstemplate :exec Template_Css()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
