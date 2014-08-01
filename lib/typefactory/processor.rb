module Typefactory

  class Processor

    @buffer = nil

    # @param original [String] a text for preparing
    def initialize(original)
      @buffer = original
    end

    # @return [String] web-prepared text
    def prepare
      cleanup
      escape_html
      quotes
      descape_html
      emdashes
      short_words
      @buffer
    end

    private

    # Purging text from already replaced glyphs (includes quotation marks of whole levels)
    def cleanup

      # Replacing all special chars to human-like marks
      Typefactory::glyphs.each do |glyph, settings|
        @buffer.gsub!(/#{settings[:sign]}|#{settings[:letter_code]}|#{settings[:digital_code]}/, settings[:mark])
      end

      # Replacing quote marks
      expression = String.new
      Typefactory::quote_marks.each do |mark|
        expression += "#{mark[:left]}|#{mark[:right]}|"
      end
      @buffer.gsub!(/#{expression[0..-2]}/, Typefactory::glyphs[:quot][:mark])

    end

    def escape_html
      @buffer.gsub!(/<([^\/].*?)>/) { |block| block.gsub(/"/, '\'') }
    end

    def descape_html
      @buffer.gsub!(/<([^\/].*?)>/) { |block| block.gsub(/'/, '"') }
    end

    # Quotes
    def quotes
      result = String.new
      level  = -1
      @buffer.split('').each_with_index do |character, index|
        if character == '"'
          side = quote_mark_side(index)
          if side == :left
            level  += 1
            result += Typefactory::quote_marks[level][side]
          else
            result += Typefactory::quote_marks[level][side]
            level  -= 1
          end
        else
          result += character
        end
      end
      @buffer.replace result
    end

    def quote_mark_side(index)
      before = space_before_position(index)
      after  = space_after_position(index)
      if !before.nil? and !after.nil?
        (before < after) ? :left : :right
      elsif !before.nil? and after.nil?
        :left
      elsif before.nil? and !after.nil?
        :right
      else
        :right
      end
    end

    def space_before_position(index, length = 4)
      to       = (index-1 < 0) ? 0 : index-1
      from     = (index-length < 0) ? 0 : index-length
      position = @buffer[from..to].rindex(/\s|\-|>/)
      if position.nil?
        index < length ? 0 : nil
      else
        length - position
      end
    end

    def space_after_position(index, length = 4)
      to       = (index+length > @buffer.length) ? @buffer.length : index+length
      from     = (index+1 > @buffer.length) ? @buffer.length : index+1
      position = @buffer[from..to].index(/\s|\-|<|,/)
      if position.nil?
        length if index > @buffer.length - length
      else
        position
      end
    end

    def short_words
      @buffer.gsub!(/\s([a-zA-Z,а-яА-Я]{1,2})\s/) { |word| " #{$1}#{Typefactory::glyphs[:nbsp][:sign]}" }
    end

    def emdashes
      @buffer.gsub!(/\s\-\s/, "#{Typefactory::glyphs[:nbsp][:sign]}#{Typefactory::glyphs[:mdash][:sign]} ")
    end

  end
end