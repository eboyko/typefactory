require 'spec_helper'

RSpec.describe 'Typefactory' do

  describe 'Core' do
    it 'Parameters can be updated successfully' do
      Typefactory.setup do |config|
        config.quote_marks = [
          { :left => '«', :right => '»' },
          { :left => '„', :right => '“' },
          { :left => '‘', :right => '’' }
        ]
        expect(config.quote_marks.class).to eq(Array)
        expect(config.quote_marks[2][:right]).to eq('’')
      end
    end
  end

  describe 'Quotation (basic examples)' do
    it 'Processing first level' do
      example = 'Типовой "текст" в кавычках'
      expect(example.prepare).to eq('Типовой «текст» в кавычках')
    end

    it 'Processing second level' do
      example = '"Различные "ученые" от пикап-индустрии"'
      expect(example.prepare).to eq('«Различные „ученые“ от пикап-индустрии»')
    end

    it 'Processing third level' do
      example = '"Быть может, когда-нибудь "все мы будем жить в "лучшем" мире""'
      expect(example.prepare).to eq('«Быть может, когда-нибудь „все мы будем жить в ‘лучшем’ мире“»')
    end
  end


  describe 'Quotation (complicated exampled)' do
    it 'processing marks in start/end positions' do
      example = '"""Никакой" другой" типограф"'
      expect(example.prepare).to eq('«„‘Никакой’ другой“ типограф»')
    end

    it 'Корректно распознает один уровень кавычек в составных словах с дефисом' do
      example = 'Кавычки-"елочки"'
      expect(example.prepare).to eq('Кавычки-«елочки»')

      example = '"Елочки"-сосны'
      expect(example.prepare).to eq('«Елочки»-сосны')
    end

    it 'Расставляет неразрывные пробелы' do
      example = 'Едет Санта на оленях'
      expect(example.prepare).to eq('Едет Санта на оленях')
    end
  end

  describe 'Glyphs' do
    it 'Process long dashes' do
      example = 'Писец - не только ценный мех'
      expect(example.prepare).to eq('Писец — не только ценный мех')
    end
  end

end