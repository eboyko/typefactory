# Typefactory

Gem prepares text for publication on the web. This release is first alpha version.

## Installation

Add this line to your application's Gemfile:

    gem 'typefactory', '0.0.1'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install typefactory

## Usage

Add initializer with

    $ rails generate typefactory config

Use typefactory for any String variables new method `typeit`:
    
    `'Какой-то "странный" текст, "наборанный "кириллицей"".typeit'`

## Contributing

1. Fork it ( https://github.com/eboyko/typefactory/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new pull request
