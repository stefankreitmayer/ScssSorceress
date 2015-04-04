# ScssSorceress
Ruby script for indenting .scss files

It treats nested blocks and line comments as one would expect. For example:

```
.outer{
  .inner{
    some stuff
    //comment
  }
}
```

## Installation

Run the script from the command line like this

```
ruby scss_sorceress.rb < foo.scss
```

or make it executable and add this like at the top:

```
#! /path/to/your/ruby
```

Personally I like to call it from Vim

## Demos

The demo folder contains some .scss files that end up nicely indented when you run them through the script.

Tested with Ruby 2.2.1
