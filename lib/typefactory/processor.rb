module Typefactory

  class Processor

    @buffer = nil

    def initialize(original)
      @buffer = original
    end

    def prepare
      cleanup
      preserve_html
      process_quotes
      revive_html
      process_emdaches
      process_short_words

      @buffer
    end

    private

    def cleanup
      GLYPHS.each do |key, glyph|
        @buffer.gsub!(/#{glyph[:entity]}|#{glyph[:decimal]}|#{glyph[:symbol]}/) do
          glyph[:mark]
        end
      end

      expression = ''
      QUOTES.each_pair do |locale, quotes|
        quotes.each do |level|
          level.each do |side, glyph|
            expression += "#{glyph[:symbol]}|#{glyph[:entity]}|#{glyph[:decimal]}|"
          end
        end
      end
      @buffer.gsub!(/#{expression[0..-2]}/, GLYPHS[:quot][:mark])
    end

    def preserve_html
      @buffer.gsub!(/<([^\/].*?)>/) do |tag|
        tag.gsub(/"/, '\'')
      end
    end

    def revive_html
      @buffer.gsub!(/<([^\/].*?)>/) do |tag|
        tag.gsub(/'/, '"')
      end
    end

    def process_quotes
      result = String.new
      level  = -1
      @buffer.split('').each_with_index do |character, index|
        if character == '"'
          side = quote_mark_side(index)
          if side == :left
            level  += 1
            level  = QUOTES[LOCALE].length - 1 if level > QUOTES[LOCALE].length - 1
            result += QUOTES[LOCALE][level][side][MODE]
          else
            result += QUOTES[LOCALE][level][side][MODE]
            level  -= 1
            level  = -1 if level < -1
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

    def process_short_words
      @buffer.gsub!(/(\s)([a-z,A-Z,а-я,А-Я]{1,2})\s(\S)/) do
        "#{$1}#{$2}#{GLYPHS[:nbsp][MODE]}#{$3}"
      end
    end

    def process_emdaches
      @buffer.gsub!(/\s\-\s/) do
        "#{GLYPHS[:nbsp][MODE]}#{GLYPHS[:mdash][MODE]} "
      end
    end

  end
end