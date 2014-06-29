require 'typefactory/string'
require 'typefactory/character'
require 'active_support/dependencies'

module Typefactory

  mattr_accessor :quotes_marks

  def self.setup
    yield self
  end

  def self.quote_mark(side, depth)
    if depth > 2
      depth = 2
    elsif depth < 0
      depth = 0
    end
    self.quotes_marks[depth][side]
  end

  def self.process(string, params = nil)
    String.new(string).prepare(params)
  end

end

class String
  def typeit(params = nil)
    Typefactory.process self, params
  end
end