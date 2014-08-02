require 'typefactory/core_ext'
require 'active_support/dependencies'

module Typefactory

  autoload :Processor, 'typefactory/processor'

  MODE = :entity

  LOCALE = :ru

  QUOTES = {
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

  GLYPHS = {
    nbsp:  { mark: ' ', symbol: ' ', entity: '&nbsp;', decimal: '&#160;' },
    quot:  { mark: '"', symbol: '"', entity: '&quot;', decimal: '&#34;' },
    mdash: { mark: '-', symbol: '—', entity: '&mdash;', decimal: '&#151;' },
    copy:  { mark: '(c)', symbol: '©', entity: '&copy;', decimal: '&#169;' },
    apos:  { mark: '\'', symbol: '’', entity: '&rsquo;', decimal: '&#146;' }
  }

  def self.setup
    yield self
  end

  def self.prepare(text)
    Processor.new(text).prepare
  end

end