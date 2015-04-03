require 'rspec'
require './scss_sorceress'

describe ScssSorceress do
  let(:indenter) {ScssSorceress.new}

  describe '#indent_text' do
    it 'removes all leading spaces and tabs from the first line' do
      expect(indenter.indent_text('      abc')).to eql('abc')
      expect(indenter.indent_text("\t\tabc")).to eql('abc')
    end

    it 'increases indentation for each extra { in the previous line' do
      expect(indenter.indent_text("abc{\ndef")).to eql("abc{\n  def")
    end

    it 'decreases indentation with each extra } in the current line' do
      expect(indenter.indent_text("aaa{\nbbb\n}")).to eql("aaa{\n  bbb\n}")
    end

    it 'considers a line as empty if it contains only space, tab or newline' do
      expect(indenter.line_empty?(" \t\n")).to eql(true)
    end

    it 'does not indent empty lines' do
      expect(indenter.indent_text("a{\n\n \t \n")).to eql("a{\n\n\n")
    end

    it 'restores indentation after unindented blank lines' do
      expect(indenter.indent_text("a{\n\nb")).to eql("a{\n\n  b")
    end

    it 'returns empty string for empty string' do
      expect(indenter.indent_text('')).to eql('')
    end

    it 'allows inline blocks without affecting indentation' do
      expect(indenter.indent_text("aaa{bbb}\nccc")).to eql("aaa{bbb}\nccc")
    end

    it 'also removes any trailing whitespace except newline' do
      expect(indenter.indent_text("a \t")).to eql("a")
      expect(indenter.indent_text("a \t\n")).to eql("a\n")
    end
  end

  describe '#indent_line' do
    it 'indents a line by a given number of double spaces' do
      expect(indenter.indent_line('a', 0)).to eql('a')
      expect(indenter.indent_line('a', 1)).to eql('  a')
      expect(indenter.indent_line('a', 2)).to eql('    a')
    end
  end

  it 'can tell how deeply a line is indented' do
    expect(indenter.depth_of_line('a')).to eql(0)
    expect(indenter.depth_of_line(' a')).to eql(0)
    expect(indenter.depth_of_line('  a')).to eql(1)
    expect(indenter.depth_of_line('    a')).to eql(2)
  end

end
