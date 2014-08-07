module Typefactory

  class Processor

    # @param original [String]
    def initialize(original)
      @buffer = original
    end

    # @param settings [Array]
    # @return [String]
    def prepare(settings = nil)

      @settings = settings.nil? ? Typefactory::settings : Typefactory::settings | settings

      cleanup if @settings.include?(:clean) and !@settings.include?(:no_clean)

      preserve_html

      process_quotes if @settings.include?(:quotes) and !@settings.include?(:no_quotes)

      revive_html

      process_dashes if @settings.include?(:dashes) and !@settings.include?(:no_dashes)

      process_widows if @settings.include?(:glue_widows) and !@settings.include?(:no_glue_widows)

      @buffer

    end

    private

    # Очищает текст от уже расставленных глифов
    def cleanup
      Typefactory::glyphs.each do |key, glyph|
        @buffer.gsub!(/#{glyph[:entity]}|#{glyph[:decimal]}|#{glyph[:symbol]}/) do
          glyph[:mark]
        end
      end

      expression = ''
      Typefactory::quotes.each_pair do |locale, quotes|
        quotes.each do |level|
          level.each do |side, glyph|
            expression += "#{glyph[:symbol]}|#{glyph[:entity]}|#{glyph[:decimal]}|"
          end
        end
      end
      @buffer.gsub!(/#{expression[0..-2]}/, Typefactory::glyphs[:quot][:mark])
    end

    # Экранирует параметры тегов HTML
    def preserve_html
      @buffer.gsub!(/<([^\/].*?)>/) do |tag|
        tag.gsub(/"/, '\'')
      end
    end

    # Снимает экранирование с тегов HTML
    def revive_html
      @buffer.gsub!(/<([^\/].*?)>/) do |tag|
        tag.gsub(/'/, '"')
      end
    end

    # Расставляет правильные многоуровневые кавычки
    def process_quotes
      result = ''
      depth  = -1
      @buffer.split('').each_with_index do |char, index|
        if char == '"'
          side = quote_mark_side index
          if side == :left
            depth  += 1
            result += Typefactory::quote(depth, side)
          else
            result += Typefactory::quote(depth, side)
            depth  -= 1
          end
        else
          result += char
        end
      end

      @buffer.replace result
    end

    # Определяет сторону кавычки на указаной позиции
    # @param index [Integer] позиция кавычки в строке
    def quote_mark_side(index)
      before = space_before_position index
      after  = space_after_position index

      if !before.nil? and !after.nil?
        if before == after

          if index == 0
            :left
          elsif index == @buffer.length-1
            :right
          else

            if @buffer[index+1..index+1].scan(/[A-Za-zА-Яа-я0-9]/).any?
              :left
            else
              :right
            end

          end

        elsif before < after
          :left
        else
          :right
        end
      elsif !before.nil? and after.nil?
        :left
      elsif !after.nil? and before.nil?
        :right
      end
    end

    # @param index [Integer] контрольная позиция селектора
    # @param length [Integer] количество возвращаемых символов перед контрольной позицией
    # @return [String]
    def characters_before(index, length)
      start_position = (index-length > 0) ? index-length : 0
      end_position   = (index-1 > 0) ? index-1 : 0
      @buffer[start_position..end_position]
    end

    # @param index [Integer] контрольная позиция селектора
    # @param length [Integer] количество возвращаемых символов после контрольной позиции
    # @return [String]
    def characters_after(index, length)
      start_position = index+1 < @buffer.length ? index+1 : @buffer.length-1
      end_position   = index+length < @buffer.length ? index+length : @buffer.length-1
      @buffer[start_position..end_position]
    end

    # Расстояние до ближайшего пробельного символа слева от текущей позиции
    # @param index [Integer]
    # @param length [Integer]
    # @return [Integer, Nil]
    def space_before_position(index, length = 4)
      expression = /\s|\-|>|\(/
      space_at   = characters_before(index, length).rindex(expression)
      if space_at.nil?
        if index < length
          0
        else
          nil
        end
      else
        if index < length
          space_at + 1
        else
          length - space_at
        end
      end

    end

    # Расстояние до ближайшего пробельного символа справа от текущей позиции
    # @param index [Integer]
    # @param length [Integer]
    # @return [Integer, Nil]
    def space_after_position(index, length = 4)
      expression = /\s|\-|<|\.|,|!|\?|:|;|\)/
      space_at   = characters_after(index, length).index(expression)
      if space_at.nil?
        if index > @buffer.length-length-1
          0
        else
          nil
        end
      else
        space_at + 1
      end

    end

    # Расставляет неразрывные пробелы после слов длиной до трех символов
    def process_widows
      @buffer.gsub!(/(\s)([a-z,A-Z,а-я,А-Я]{1,2})\s(\S)/) do
        "#{$1}#{$2}#{Typefactory::glyphs[:nbsp][Typefactory::mode]}#{$3}"
      end
    end

    # Расставляет длинные тире
    def process_dashes
      @buffer.gsub!(/\s\-\s/) do
        "#{Typefactory::glyphs[:nbsp][Typefactory::mode]}#{Typefactory::glyphs[:mdash][Typefactory::mode]} "
      end
    end

  end
end