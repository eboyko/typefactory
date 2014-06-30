module Typefactory
  class Character < ::String

    attr_accessor :parent
    @parent = nil

    attr_accessor :index
    @index = nil

    def is_quote_mark?
      if self == '"'
        true
      else
        false
      end
    end

    def has_space_before_in(count=4)
      count  = (@index-count<0) ? count+(@index-count) : count
      string = @parent[@index-count, count]
      if @index <= count
        1
      elsif /\s|>|\-$/.match(string) or /\s([\S]{1,3})$/.match(string)
        count - string.index(/\s/).to_i
      else
        nil
      end
    end

    def has_space_after_in(count=4)
      length = @parent.length - 1
      count  = (@index+count < length) ? count : length-(length-@index)
      string = @parent[@index+1, count]
      if @index >= length - count
        1
      elsif /^\s|</.match(string) or /^([\S]{1,3})\s/.match(string)
        string.index(/\s/).to_i + 1
      else
        nil
      end
    end

    def quote_mark_side
      before_point = self.has_space_before_in
      after_point  = self.has_space_after_in
      if !before_point.nil? and !after_point.nil?
        (before_point < after_point) ? :left : :right
      elsif before_point.nil? and !after_point.nil?
        :right
      elsif !before_point.nil? and after_point.nil?
        :left
      end
    end

  end
end