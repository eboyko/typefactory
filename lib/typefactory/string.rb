module Typefactory
  class String < ::String

    def prepare(params = nil)
      self.cleanup
      self.set_quotes
    end

    def characters
      index = 0
      self.split('').each do |character|
        character        = Character.new(character)
        character.parent = self
        character.index  = index

        yield character
        index += 1
      end
    end

    def cleanup
      expression = ::String.new
      Typefactory::quotes_marks.each { |l| expression += "#{l[:left]}|#{l[:right]}|" }
      expression += "&quot;"
      self.replace(self.gsub(/#{expression}/, '"'))
    end

    def set_quotes
      depth  = -1
      result = ::String.new
      self.replace(self.gsub(/<([^\/].*?)>/) { |block| block.gsub(/"/, '\'') })
      self.characters do |character|
        if character.is_quote_mark?
          side = character.quote_mark_side
          if side == :left
            depth  += 1
            result += Typefactory::quote_mark(:left, depth)
          else
            result += Typefactory::quote_mark(:right, depth)
            depth  -= 1
          end
        else
          result += character
        end
      end
      result.gsub(/<([^\/].*?)>/) { |block| block.gsub(/'/, '"') }
    end

  end
end