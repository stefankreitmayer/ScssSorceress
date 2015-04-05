# ScssSorceress
Ruby script for fixing the indentation of .scss files

## What it does

1. read from stdin
2. count the curly brackets
3. indent each line accordingly, using double spaces
4. write to stdout

Here is some example output:

```
.outer{
  .inner{
    some stuff
    //comment
  }
}
```

That's it, essentially. No messing with linebreaks or anything fancy. Some people prefer breaking their scss lines manually - I am one of them.

## Install

Assuming you have ruby installed (I've tested this script in ruby 2.2.1), all you need to do is save scss_sorceress.rb in the directory of your choice.

## Run in command line

```
ruby scss_sorceress.rb <ugly.scss >pretty.scss
```

## Plug into Vim 

You can inject the script as a filter.

```
:1,$!{ruby /foo/bar/scss_sorceress.rb}
```

The command above indents the current buffer.

Since I'm using this a lot, I added a little function to my .vimrc file:

```
function! IndentBuffer()
  normal! my
  if match(expand('%'), '\.scss$') != -1
    :1,$!{ruby /foo/bar/scss_sorceress.rb}
  else
    normal! gg=G
  endif
  normal! `y
endfunction

nnoremap <leader>= :call IndentBuffer()<cr>
```

The code above does the following

1. make a note of the current cursor position
2. call ScssSorceress if the file name ends in .scss - otherwise perform the built-in indentation
3. restore the cursor position
4. map the function to ```leader =``` for convenience


## Demos

The demo folder contains some poorly indented .scss files that look nice after you run them through ScssSorceress.
