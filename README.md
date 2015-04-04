# ScssSorceress
Ruby script for indenting .scss files

Handles nested blocks and line comments as expected. For example:

.outer{
  .inner{
    some stuff
    //comment
  }
}

## Installation

Run it from the command line like this
ruby scss_sorceress.rb < foo.scss

or make it executable and add this to the top of the file:
#! /path/to/your/ruby

I usually call it from within vim.

## Try it out

The demo folder contains some .scss files that end up nicely indented when you run them through the script.

Tested with Ruby 2.2.1
