String.class_eval do
  def prepare(*settings)
    Typefactory::prepare(self, *settings)
  end
end