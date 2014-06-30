require 'spec_helper'

RSpec.describe 'Тайпфектори' do

  describe 'Ядро' do
    it 'Нормально конфигурируется' do
      Typefactory.setup do |config|
        config.quotes_marks = [
          { :left => "«", :right => "»" },
          { :left => "„", :right => "“" },
          { :left => "‘", :right => "’" }
        ]
        expect(config.quotes_marks.class).to eq(Array)

        config.non_breaking_space = '&nbsp;'
        expect(config.non_breaking_space.class).to eq(String)
      end
    end
  end

  describe 'Текстовый процессор' do
    it 'Корректно распознает три уровня кавычек' do
      example = '"""Нормальная" обработка" кавычек"'
      expect(example.typeit).to eq('«„‘Нормальная’ обработка“ кавычек»')
    end

    it 'Корректно распознает один уровень кавычек в составных словах с дефисом' do
      example = 'Кавычки-"елочки"'
      expect(example.typeit).to eq('Кавычки-«елочки»')

      example = '"Елочки"-сосны'
      expect(example.typeit).to eq('«Елочки»-сосны')
    end

    it 'Расставляет неразрывные пробелы' do
      example = 'Едет Санта на оленях'
      expect(example.typeit).to eq('Едет Санта на&nbsp;оленях')
    end
  end

end