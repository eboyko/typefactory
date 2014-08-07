require 'typefactory/core_ext'

module Typefactory

  autoload :Processor, 'typefactory/processor'

  @mode = :symbol

  @locale = :ru

  @settings = [
    :clean,
    :quotes,
    :dashes,
    :glue_widows
  ]

  @quotes = {
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

  @glyphs = {
    nbsp:  { mark: ' ', symbol: ' ', entity: '&nbsp;', decimal: '&#160;' },
    quot:  { mark: '"', symbol: '"', entity: '&quot;', decimal: '&#34;' },
    mdash: { mark: '-', symbol: '—', entity: '&mdash;', decimal: '&#151;' },
    copy:  { mark: '(c)', symbol: '©', entity: '&copy;', decimal: '&#169;' }
  }


  # @param mode [Symbol] возможные значения `:symbol`, `:entity` или `:decimal`
  def self.mode=(mode)
    @mode = mode
  end

  # @return [Symbol]
  def self.mode
    @mode
  end

  # @param locale [Symbol]
  def self.locale=(locale)
    @locale = locale
  end

  # Локаль, определяющая используемые глифы; по умолчанию `:ru`
  # @return [Symbol]
  def self.locale
    @locale
  end

  # @param settings [Array<Symbol>]
  def self.settings=(settings)
    @settings = settings
  end

  # @return [Array<Symbol>]
  def self.settings
    @settings
  end

  # @param glyphs [Hash{Symbol => Hash}]
  def self.glyphs=(glyphs)
    @glyphs = glyphs
  end

  # @todo по-человечески описать формат возвращаемых данных
  # @return [Hash{Symbol => Hash}]
  def self.glyphs
    @glyphs
  end

  # @param quotes [Hash]
  def self.quotes=(quotes)
    @quotes = quotes
  end

  # @todo по-человечески описать формат возвращаемых данных
  # @return [Hash]
  def self.quotes
    @quotes
  end

  # Возвращает знак кавычки для выбранных уровня глубины и стороны
  # @param depth [Integer]
  # @param side [Symbol] `:left` or `:right`
  def self.quote(depth = 0, side = :left)
    depth = 0 if depth < 0
    count = @quotes[@locale].length - 1
    depth = count if depth > count
    @quotes[@locale][depth][side][@mode]
  end

  # Метод настройки модуля с помощью файла инициализации (по аналогии с Devise)
  # @yield [Typefactory]
  def self.setup
    yield self
  end

  # Обрабатывает текст с учетом заданных параметров
  # @param text [String]
  # @param [Array<Symbol>] settings
  # @return [String]
  def self.prepare(text, *settings)
    Processor.new(text).prepare(settings)
  end

end