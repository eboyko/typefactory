require 'spec_helper'

RSpec.describe 'Typefactory' do

  describe 'Configuration' do
    it 'Successfully sets up configuration' do
      Typefactory.setup do |config|
        config.quotes_marks = [
          { :left => "«", :right => "»" },
          { :left => "„", :right => "“" },
          { :left => "‘", :right => "’" }
        ]
        expect(config.quotes_marks.class).to eq(Array)
      end
    end
  end

  describe 'Processor' do
    it 'Correctly processing three levels quotes' do
      example = '"""Нормальная" обработка" кавычек"'
      expect(example.typeit).to eq('«„‘Нормальная’ обработка“ кавычек»')
    end

    it 'Correctly processing complex words with quotes in one part' do
      example = 'Кавычки-"елочки"'
      expect(example.typeit).to eq('Кавычки-«елочки»')

      example = '"Елочки"-сосны'
      expect(example.typeit).to eq('«Елочки»-сосны')
    end
  end

end