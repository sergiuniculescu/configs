syntax on
set background=dark

set autoindent
filetype indent on
set shiftwidth=2
set tabstop=2
set nopaste
set pastetoggle=<F2>

if &background == "dark"
hi Comment term=bold ctermfg=DarkCyan guifg=#80a0ff
hi Constant term=underline ctermfg=Magenta guifg=Magenta
hi Special term=bold ctermfg=DarkMagenta guifg=Red
hi Identifier term=underline cterm=bold ctermfg=Cyan guifg=#40ffff
hi Statement term=bold ctermfg=Yellow gui=bold guifg=#aa4444
hi PreProc term=underline ctermfg=LightBlue guifg=#ff80ff
hi Type term=underline ctermfg=LightGreen guifg=#60ff60 gui=bold
hi Function term=bold ctermfg=White guifg=LightRed
hi Repeat term=underline ctermfg=White guifg=LightRed
hi Operator ctermfg=Red guifg=Red
hi Ignore ctermfg=black guifg=bg
else
hi Comment term=bold ctermfg=DarkBlue guifg=Blue
hi Constant term=underline ctermfg=DarkRed guifg=Magenta
hi Special term=bold ctermfg=DarkMagenta guifg=SlateBlue
hi Identifier term=underline ctermfg=DarkCyan guifg=DarkCyan
hi Statement term=bold ctermfg=Brown gui=bold guifg=Brown
hi PreProc term=underline ctermfg=DarkMagenta guifg=Purple
hi Type term=underline ctermfg=DarkGreen guifg=SeaGreen gui=bold
hi Ignore ctermfg=white guifg=bg
endif
hi Error term=reverse ctermbg=Red ctermfg=White guibg=Red guifg=White
hi Todo term=standout ctermbg=Yellow ctermfg=Black guifg=Blue guibg=Yellow

" Common groups that link to default highlighting.
" You can specify other highlighting easily.
hi link String Constant
hi link Character Constant
hi link Number Constant
hi link Boolean Constant
hi link Float Number
hi link Conditional Statement
hi link Label Statement
hi link Keyword Statement
hi link Exception Statement
hi link Include PreProc
hi link Define PreProc
hi link Macro PreProc
hi link PreCondit PreProc
hi link StorageClass Type
hi link Structure Type
hi link Typedef Type
hi link Tag Special
hi link SpecialChar Special
hi link Delimiter Special
hi link SpecialComment Special
hi link Debug Special