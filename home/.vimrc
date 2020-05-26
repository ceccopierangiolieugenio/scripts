" .vimrc
"
" Reference keys (to print out and put above your keyboard! ;):
"
"         F1      F2      F3         F4      F5      F6      F7      F8      F9     F10     F11     F12
" UnMod  NxFile  PrFile  Expandtabs SetPaste 
"

" first clear any existing autocommands:
autocmd!

" * User Interface

" Workaround to fix colorscheme on TMUX
set background=dark
set t_Co=256

" have syntax highlighting in terminals which can display colours:
if has('syntax') && (&t_Co > 2)
  syntax on
endif

" set mouse drag if we are in a tmux env
if $TMUX != ''
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" use pathogen to handle the Runtime Path Manipulation and plugins
" https://github.com/tpope/vim-pathogen
"  Install Pathogen:
"     mkdir -p ~/.vim/autoload ~/.vim/bundle && \
"     curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
"  Install lightline and NerdTree:
"     git clone https://github.com/preservim/nerdtree.git  ~/.vim/bundle/nerdtree
"     git clone https://github.com/itchyny/lightline.vim  ~/.vim/bundle/lightline.vim
execute pathogen#infect()

" Associate all config files in .ssh as sshconfig
au BufNewFile,BufRead ssh_config,*/.ssh/*config*	setf sshconfig

" have fifty lines of command-line (etc) history:
set history=70

" remember all of these between sessions, but only 10 search terms; also
" remember info for 10 files, but never any on removable disks, don't remember
" marks in files, don't rehighlight old search patterns, and only save up to
" 100 lines of registers; including @10 in there should restrict input buffer
" but it causes an error for me:
set viminfo=%,/10,'100,r/mnt/cdrom,r/mnt/floppy,f1,h,\"100

" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full

" use "[RO]" for "[readonly]" to save space in the message line:
set shortmess=aoI

" display the current mode and partially-typed commands in the status line:
set showmode
set showcmd
set showbreak=@

" when using list, keep tabs at their full width and display `arrows':
execute 'set listchars+=tab:' . nr2char(187) . nr2char(183)
" (Character 187 is a right double-chevron, and 183 a mid-dot.)

" have the mouse enabled all the time:
set mouse=n
set mousemodel=popup_setpos

" don't have files trying to override this .vimrc:
set nomodeline

" scroll 2 lines before end of file.. ;)
set so=2
set sidescroll=12

" Backups in ~/.vimbakups dir (comment following 3 lines to disable backups)
set backup
set backupext=.bak
set backupdir=~/.vimbackups

source $VIMRUNTIME/ftplugin/man.vim
runtime macros/justify.vim
set tags=./tags,./../tags,./../../tags,./../../../tags,tags,/usr/include/tags,/usr/src/linux/tags

" * Text Formatting -- General

" don't make it look like there are line breaks where there aren't:
set nowrap

" use indents of 2 spaces, and have them copied down lines:
" set shiftwidth=2
" set shiftround
" set expandtab
" set autoindent

" normally don't automatically format `text' as it is typed, IE only do this
" with comments, at 79 characters:
set formatoptions-=t
set textwidth=79

" get rid of the default style of C comments, and define a style with two stars
" at the start of `middle' rows which (looks nicer and) avoids asterisks used
" for bullet lists being treated like C comments; then define a bullet list
" style for single stars (like already is for hyphens):
set comments-=s1:/*,mb:*,ex:*/
set comments+=s:/*,mb:**,ex:*/
set comments+=fb:*

" treat lines starting with a quote mark as comments (for `Vim' files, such as
" this very one!), and colons as well so that reformatting usenet messages from
" `Tin' users works OK:
set comments+=b:\"
set comments+=n::


" * Text Formatting -- Specific File Formats

" enable filetype detection:
filetype on

" recognize anything in my .Postponed directory as a news article, and anything
" at all with a .txt extension as being human-language text [this clobbers the
" `help' filetype, but that doesn't seem to prevent help from working
" properly]:
augroup filetype
  autocmd BufNewFile,BufRead */.Postponed/* set filetype=mail
  autocmd BufNewFile,BufRead *.txt set filetype=human
augroup END

" 10t: Ritorna all'ultima posizione precedente di un file editato 
autocmd BufReadPost * if line("'\"") | exe "'\"" | endif

" in human-language files, automatically format everything at 72 chars:
autocmd FileType mail,human set formatoptions+=t textwidth=72

" for C-like programming, have automatic indentation:
autocmd FileType c,cpp,slang set cindent
" and extended ctag listing
autocmd FileType c,cpp,slang set showfulltag 
" and set indent as folded elements for F1
autocmd FileType c,cpp,slang set foldmethod=indent
autocmd FileType c,cpp,slang set foldlevel=999

" for actual C (not C++) programming where comments have explicit end
" characters, if starting a new line in the middle of a comment automatically
" insert the comment leader characters:
autocmd FileType c set formatoptions+=ro

" for Perl programming, have things in braces indenting themselves:
autocmd FileType perl set smartindent

" for CSS, also have things in braces indented:
autocmd FileType css set smartindent

" for HTML, generally format text, but if a long line has been created leave it
" alone when editing:
autocmd FileType html set formatoptions+=tl

" for both CSS and HTML, use genuine tab characters for indentation, to make
" files a few bytes smaller:
" autocmd FileType html,css set noexpandtab tabstop=2

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
" autocmd FileType make set noexpandtab shiftwidth=8

" * Search & Replace

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" show the `best match so far' as search strings are typed:
set incsearch

" higlight search
set hlsearch


" * Spelling

" define `Ispell' language and personal dictionary, used in several places
" below:
let IspellLang = 'british'
let PersonalDict = '~/.ispell_' . IspellLang

" mappa gf per andare nel file sotto al cursore ma aprire una nuova finestra
map gf :sfind <cfile><CR>

" Spell checking operations are defined next.  They are all set to normal mode
" keystrokes beginning \s but function keys are also mapped to the most common
" ones.  The functions referred to are defined at the end of this .vimrc.

" \si ("spelling interactive") saves the current file then spell checks it
" interactively through `Ispell' and reloads the corrected version:
execute 'nnoremap \si :w<CR>:!ispell -x -d ' . IspellLang . ' %<CR>:e<CR><CR>'

" \sl ("spelling list") lists all spelling mistakes in the current buffer,
" but excludes any in news/mail headers or in ("> ") quoted text:
execute 'nnoremap \sl :w ! grep -v "^>" <Bar> grep -E -v "^[[:alpha:]-]+: " ' .
  \ '<Bar> ispell -l -d ' . IspellLang . ' <Bar> sort <Bar> uniq<CR>'

" \sh ("spelling highlight") highlights (in red) all misspelt words in the
" current buffer, and also excluding the possessive forms of any valid words
" (EG "Ilda's" won't be highlighted if "Ilda" is in the dictionary); with
" mail and news messages it ignores headers and quoted text; for HTML it
" ignores tags and only checks words that will appear, and turns off other
" syntax highlighting to make the errors more apparent [function at end of
" file]:
"nnoremap \sh :call HighlightSpellingErrors()<CR><CR>
"nmap <F9> \sh

" \sc ("spelling clear") clears all highlighted misspellings; for HTML it
" restores regular syntax highlighting:
nnoremap \sc :if &ft == 'html' <Bar> sy on <Bar>
  \ else <Bar> :sy clear SpellError <Bar> endif<CR>
nmap <S-F9> \sc


" * Keystrokes -- Moving Around

" have the h and l cursor keys wrap between lines (like <Space> and <BkSpc> do
" by default), and ~ covert case over line breaks; also have the cursor keys
" wrap in insert mode:
set whichwrap=h,l,~,[,],<,>

" have % bounce between angled brackets, as well as t'other kinds:
set matchpairs+=<:>

" * Keystrokes -- Toggles

" Keystrokes to toggle options are defined here.  They are all set to normal
" mode keystrokes beginning \t but some function keys (which won't work in all
" terminals) are also mapped.

" Map NERDTree to CTRL-n
map <C-n> :NERDTreeToggle<CR>

" have <F1> prompt for a help topic, rather than displaying the introduction
" page, and have it do this from any mode:
nnoremap <F1> :bnext!<CR>
imap <F1> <ESC> :bnext!<CR>
noremap <F2> :bprevious! <CR>
imap <F2> <ESC> :bprevious! <CR>

" have \tp ("toggle paste") toggle paste on/off and report the change, and
" where possible also have <F4> do this both in normal and insert mode:
nnoremap \tp :set invpaste paste?<CR>
nmap <F4> \tp
imap <F4> <C-O>\tp
set pastetoggle=<F4>

nnoremap \tet :set invexpandtab expandtab?<CR>
nmap <F3> \tet
imap <F3> <C-O>\tet


" end of .vimrc

