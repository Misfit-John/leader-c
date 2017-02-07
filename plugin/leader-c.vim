"This is leader c plugin, I wanna expand this to a fully runing comment plugin

function! GetCommentWord(default)
  let a:comment_word = a:default
	if a:0 >= 1
		let a:comment_word=a:1
  else
    let a:curFileType = &filetype
    if 1 == has_key(g:comment_map,a:curFileType)
        let a:comment_word=g:comment_map[a:curFileType]
    endif
	endif
  return escape(a:comment_word,'"')
endfunction

function! CommentTriggerWorker(comment_word)
  let a:curLine = getline('.')

  if 0 == match(a:curLine, "^\\s*".a:comment_word)
    let a:exec_command = "s\/^\\s*".escape(a:comment_word,'/.')."\/"
  else
    let a:exec_command = "s\/^\/".escape(a:comment_word, '/.')."/"
  endi

  exec a:exec_command
endfunction

function! CommentTrigger(mode,...) 
  let a:modeName = a:mode
  if a:modeName == 'v'
    let a:modeName = visualmode()
  endif
  
  "now comment
  let a:comment_word = GetCommentWord("\\/\\/")
  if "\\/\\/" == a:comment_word && "v" == a:modeName
    "this is a virtual mode entered by "v"
    exec "call PartComment(\"\\/*\",\"*\\/\",\"".a:modeName."\")"
  elseif "<!--" == a:comment_word 
    exec "call PartComment(\"<!--\",\"-->\",\"".a:modeName."\")"
  elseif "v" == a:mode
    "this is a virsual mode, not entered by "v"
    exec "'<,'> call CommentTriggerWorker(\"".a:comment_word."\")"
  else
    exec "call CommentTriggerWorker(\"".a:comment_word."\")"
  endif
endfunction

function! PartComment(begin,end,mode)
    exec "set paste"
    let a:exec_command = "normal gv\"xdi".a:begin."\<C-r>x".a:end."\<Esc>"
    exec a:exec_command
    exec "set nopaste"
endfunction

let g:comment_map={ 'vim': '"', 'sh': '#', 'python': '#', 'yaml': '#', 'conf':'#', 'cfg':'#', 'xml':'<!--', 'pig': '--', 'lua': '--', 'cmake': '#', 'make': '#', 'erlang': '%'}

nmap <leader>c :call CommentTrigger('n')<CR>
vmap <leader>c <Esc>:call CommentTrigger('v')<CR>

