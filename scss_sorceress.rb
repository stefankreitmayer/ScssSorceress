class ScssSorceress

  def indent_text(text)
    return '' if text.empty?
    output = ''
    @next_depth = 0
    text.each_line do |line|
      if output.empty?
        output << indent_line(line, 0)
        set_next_depth(line)
      else
        output << autoindent_line(line)
      end
    end
    output
  end

  def indent_line(line, depth)
    '  ' * zero_or_more(depth) + trim(line)
  end

  def depth_of_line(line)
    line.index(/[^ \t]/) / 2
  end

  def line_empty?(line)
    line.index(/[^ \t\n]/) == nil
  end

  private

  def set_next_depth(line)
    @next_depth += count_opening(line)
  end

  def autoindent_line(line)
    if line_empty?(line)
      indent_line(line, 0)
    else
      depth = zero_or_more(@next_depth - count_closing(line))
      result = indent_line(line, depth)
      set_next_depth(result)
      result
    end
  end

  def trim(line)
    trim_tail(trim_head(line))
  end

  def trim_head(line)
    line.slice(line.index(/[^ \t]/)..-1)
  end

  def trim_tail(line)
    line.index("\n") ? line.rstrip + "\n" : line.rstrip
  end

  def count_opening(line)
    zero_or_more(line.count('{') - line.count('}'))
  end

  def count_closing(line)
    zero_or_more(line.count('}') - line.count('{'))
  end

  def zero_or_more(n)
    n < 0 ? 0 : n
  end
end

if $0==__FILE__
  text = ''
  while line_from_stdin = gets
    text << line_from_stdin
  end
  puts ScssSorceress.new.indent_text(text)
end
