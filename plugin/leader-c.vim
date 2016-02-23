"This is leader c plugin, I wanna expand this to a fully runing comment plugin

function! CommentTrigger(...) 
  let a:modeName = ''
  if exists("g:lastMod")
    let a:modeName = g:lastMod
  endif
  if a:modeName == 'v'
    let a:modeName = visualmode()
  endif
  
	let a:comment_word="\\/\\/"
	if a:0 >= 1
		let a:comment_word=a:1
    else
        let a:curFileType = &filetype
        if 1 == has_key(g:comment_map,a:curFileType)
            let a:comment_word=g:comment_map[a:curFileType]
        endif
	endif
  "now comment
  if "\\/\\/" == a:comment_word && "v" == a:modeName
    "this is a virtual mode entered by "v"
    exec "normal gv\"idi\/*\<Esc>\"ipa*\/\<Esc>"
  else
    let a:curLine = getline('.')

    if 0 == match(a:curLine, a:comment_word)
      let a:exec_command = "s\/^".a:comment_word."\/"
    else
      let a:exec_command = "s\/^\/".a:comment_word."/"
    endif

    exec a:exec_command
  endif
endfunction

let g:comment_map={'vim': '"', 'sh': '#','python': '#','yaml': '#','conf':'#'}

nmap <leader>c :let g:lastMod='n'<CR>:call CommentTrigger()<CR>$
vmap <leader>c <Esc>:let g:lastMod='v'<CR>:call CommentTrigger()<CR>$
imap <leader>c <Esc>ma:let g:lastMod='i'<CR>:call CommentTrigger()<CR>`a

