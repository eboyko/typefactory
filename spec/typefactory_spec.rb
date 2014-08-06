require 'spec_helper'

RSpec.describe 'Тайпфектори' do

  describe 'В принципе' do
    it 'Нормально конфигурируется' do
      Typefactory.setup do |config|
        config.mode     = :symbol
        config.locale   = :ru
        config.settings = [:clean, :quotes, :dashes, :glue_widows]
        config.glyphs   = {
          nbsp:  { mark: ' ', symbol: ' ', entity: '&nbsp;', decimal: '&#160;' },
          quot:  { mark: '"', symbol: '"', entity: '&quot;', decimal: '&#34;' },
          mdash: { mark: '-', symbol: '—', entity: '&mdash;', decimal: '&#151;' },
          copy:  { mark: '(c)', symbol: '©', entity: '&copy;', decimal: '&#169;' }
        }
        config.quotes   = {
          ru: [
                {
                  left:  { mark: '"', symbol: '«', entity: '&laquo;', decimal: '&#171;' },
                  right: { mark: '"', symbol: '»', entity: '&raquo;', decimal: '&#187;' }
                },
                {
                  left:  { mark: '"', symbol: '„', entity: '&bdquo;', decimal: '&#132;' },
                  right: { mark: '"', symbol: '“', entity: '&ldquo;', decimal: '&#147;' }
                },
                {
                  left:  { mark: '"', symbol: '‘', entity: '&lsquo;', decimal: '&#145;' },
                  right: { mark: '"', symbol: '’', entity: '&rsquo;', decimal: '&#146;' }
                }
              ],
          en: [
                {
                  left:  { mark: '"', symbol: '“', entity: '&ldquo;', decimal: '&#147;' },
                  right: { mark: '"', symbol: '”', entity: '&rdquo;', decimal: '&#148;' }
                },
                {
                  left:  { mark: '"', symbol: '‘', entity: '&lsquo;', decimal: '&#145;' },
                  right: { mark: '"', symbol: '’', entity: '&rsquo;', decimal: '&#146;' }
                }
              ]
        }
        expect(config.locale).to eq(:ru)
        expect(config.mode).to eq(:symbol)
        expect(config.settings.class).to eq(Array)
        expect(config.glyphs.class).to eq(Hash)
        expect(config.quotes[config.locale].class).to eq(Array)
      end
    end
    it 'Не ломает HTML' do
      example = '<p>Некоторые а используют на типограф <a href="http://artlebedev.ru" class="external" target="_blank">Лебедева</a></p>'
      expect(example.prepare(:no_glue_widows)).to eq('<p>Некоторые а используют на типограф <a href="http://artlebedev.ru" class="external" target="_blank">Лебедева</a></p>')
    end
  end

  describe 'Кавычки' do
    it 'Одноуровневые без содержимого' do
      expect('""'.prepare).to eq('«»')
      expect(' "" '.prepare).to eq(' «» ')
    end

    it 'Одноуровневые в стандартном предложении' do
      example = 'Типовой "текст" в кавычках'
      expect(example.prepare(:no_glue_widows)).to eq('Типовой «текст» в кавычках')
    end

    it 'Двухуровневые в стандартном предложении' do
      example = '"Различные "ученые" от пикап-индустрии"'
      expect(example.prepare(:no_glue_widows)).to eq('«Различные „ученые“ от пикап-индустрии»')
    end

    it 'Трехуровневые в стандартном предложении' do
      example = '"Быть может, когда-нибудь "все мы будем жить в "лучшем" мире""'
      expect(example.prepare(:no_glue_widows)).to eq('«Быть может, когда-нибудь „все мы будем жить в ‘лучшем’ мире“»')
    end

    it 'Одноуровневые в дефисных словосочетаниях' do
      example = 'Кавычки-"елочки"'
      expect(example.prepare).to eq('Кавычки-«елочки»')

      example = '"Елочки"-сосны'
      expect(example.prepare).to eq('«Елочки»-сосны')
    end

  end

  describe 'Глифы' do
    it 'Неразрывные пробелы после коротких слов' do
      example = 'Едет Санта на оленях'
      expect(example.prepare).to eq('Едет Санта на оленях')
    end
    it 'Длинные тире' do
      example = 'Писец - не только ценный мех'
      expect(example.prepare(:no_glue_widows)).to eq('Писец — не только ценный мех')
    end
  end


end