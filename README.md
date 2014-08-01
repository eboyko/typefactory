# Typefactory

This simple plugin helps you to prepare your texts for publishing on the web. Typefactory was created for Russian grammar and punctuation but can be used in other languages (such as English or German).

_This is my first gem and I'll be glad to hear from you any advices about Ruby/Rails as well as about my English :-)_

## Abilities

Current beta version has only methods for processing three levels of quote marks. All used glyphs can be customized.

## Install

### Ruby on Rails

	$ gem "typefactory", "~> 0.0.10"
	$ bundle install
	

### Extension for `String`

Typefactory adds method `prepare` for standard Ruby class `String`. You can use this feature as well as default way.

	'Some text here'.prepare
	<%= @description.prepare %>


## Customize

Need customization? Please use generator:

	$ rails generate typefactory config
	
Now you can modify `config/initializers/typefactory.rb`

## Help to improve

If you have text where parsing algorithm makes mistakes, send it to me (eboyko@eboyko.ru), please.

## Contribute

1. Fork it https://github.com/eboyko/typefactory/fork
2. Create your feature branch `git checkout -b my-new-feature`
3. Commit your changes `git commit -am 'Add some feature'`
4. Push to the branch `git push origin my-new-feature`
5. Create a new pull request

