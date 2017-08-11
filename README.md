# commentor
just comment it

##how to install
use bundle to install, add the following command into your .vimrc file:

```
Plugin 'johnzeng/commentor'
```

##Key-Map:
in normal mode or visual mode, type `<leader>c` and that's all :)

```vim
normal mode, press <leader>c -> 
comment a line or un-comment a line
```

```vim
visual mode entered by V , press <leader>c -> 
comment the selected lines or un-comment the selected lines
```

```vim
visual mode entered by v -> 
comment a block by /**/ or <--! --> (I will think about un-comment in future, if anybody need it.)
```


I don't didn't try all kinds of language , so I don't feel it's enough for all people to use it. Feel free to open an issue if you wanna other language's support

##setting
###`g:comment_map`
This is the comment map for different file type.Key, is file type, and value is the line comment character for that file. You can see the file type by typing `:echo &filetype` in vi.

Following is default.

```
let g:comment_map={'vim': '"', 'sh': '#','python': '#','yaml': '#','conf':'#','cfg':'#', 'xml':'<!--'}
```

### `g:comment_key`

This is the key to trigger comment

**Note: if the file type doesn't match any of the provided map, it will use // to do comment. And /* */ to do block comment**

##what is `<leader>`?
Basically <leader> is `\` by default . The reason why we don't call `\c` is because you can set you own <leader> mapping by yourself.

Type `:help <leader>` in vi for help

