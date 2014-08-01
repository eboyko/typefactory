require 'typefactory/core_ext'
require 'active_support/dependencies'

module Typefactory

  autoload :Processor, 'typefactory/processor'

  @@locale = :ru
  mattr_accessor :locale

  @@use = :letter_code
  mattr_accessor :use

  @@quote_marks = {
    ru: [
      {
        left:  { mark: '"', sign: '«', letter_code: '&laquo;', digital_code: '&#171;' },
        right: { mark: '"', sign: '»', letter_code: '&raquo;', digital_code: '&#187;' },
      }, {
        left:  { mark: '"', sign: '„', letter_code: '&bdquo;', digital_code: '&#8222;' },
        right: { mark: '"', sign: '“', letter_code: '&ldquo;', digital_code: '&#8220;' },
      }, {
        left:  { mark: '"', sign: '‘', letter_code: '&lsquo;', digital_code: '&#8216;' },
        right: { mark: '"', sign: '’', letter_code: '&rsquo;', digital_code: '&#8217;' }
      }
    ]
  }
  mattr_accessor :quote_marks

  @@glyphs = {
    nbsp:  { mark: ' ', sign: ' ', letter_code: '&nbsp;', digital_code: '&#160;' },
    quot:  { mark: '"', sign: '"', letter_code: '&quot;', digital_code: '&#34;' },
    mdash: { mark: '-', sign: '—', letter_code: '&mdash;', digital_code: '&#151;' }
    # :nbsp       => ' ',
    # :ndash      => '–',
    # :mdash      => '&mdash;',
    # :minus      => '−',
    # :section    => '§',
    # :paragraph  => '¶',
    # :copy       => '©',
    # :registered => '®',
    # :trademark  => '™',
    # :degree     => '°',
    # :inch       => '″',
    # :multiple   => '×',
    # :middot     => '·',
    # :bullit     => '•',
    # :quot       => '"'
  }
  mattr_accessor :glyphs

  def self.setup
    yield self
  end

  # @note In next versions here will be `settings`
  def self.prepare(text)
    Processor.new(text).prepare
  end

end