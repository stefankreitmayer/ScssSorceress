class ScssSorceress

  def indent_text(text)
    return '' if text.empty?
    output = ''
    @next_depth = 0
    text.each_line do |line|
      if output.empty?
        output << indent_line(line, 0)
        @next_depth = non_negative(delta_brackets(line))
      else
        output << autoindent_line(line)
      end
    end
    output
  end

  def indent_line(line, depth)
    '  ' * non_negative(depth) + trim(line)
  end

  def depth_of_line(line)
    line.index(/[^ \t]/) / 2
  end

  def line_empty?(line)
    line.index(/[^ \t\n]/) == nil
  end

  private

  def autoindent_line(line)
    if line_empty?(line)
      indent_line(line, 0)
    else
      @next_depth = non_negative(@next_depth + negative(delta_brackets(line)))
      result = indent_line(line, @next_depth)
      @next_depth += non_negative(delta_brackets(line))
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

  def delta_brackets(line)
    line = strip_comments(line)
    line.count('{') - line.count('}')
  end

  def strip_comments(line)
    pos = line.index('//')
    if pos
      line.slice(0, pos)
    else
      line
    end
  end

  def negative(n)
    n > 0 ? 0 : n
  end

  def non_negative(n)
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
