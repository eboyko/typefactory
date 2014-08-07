Typefactory.setup do |config|

  config.mode = :entity

  config.locale = :ru

  config.settings = [:clean, :quotes, :dashes, :glue_widows]

  config.glyphs = {
    nbsp:  { mark: ' ', symbol: ' ', entity: '&nbsp;', decimal: '&#160;' },
    quot:  { mark: '"', symbol: '"', entity: '&quot;', decimal: '&#34;' },
    mdash: { mark: '-', symbol: '—', entity: '&mdash;', decimal: '&#151;' },
    copy:  { mark: '(c)', symbol: '©', entity: '&copy;', decimal: '&#169;' }
  }

  config.quotes = {
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
        ]
  }

end