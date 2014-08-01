require 'active_support/dependencies'

module Typefactory

  autoload :Processor, 'typefactory/processor'

  @@quote_marks = [
    { :left => '«', :right => '»' },
    { :left => '„', :right => '“' },
    { :left => '‘', :right => '’' }
  ]
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