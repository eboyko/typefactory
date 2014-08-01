String.class_eval do

  def prepare
    Typefactory::prepare(self)
  end

end