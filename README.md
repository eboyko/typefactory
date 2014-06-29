# Тайпфектори

Гем для подготовки текстов к публикации в вебе (проще говоря — типограф). Альфа-версия расставляет лишь правильные кавычки до третьего уровня включительно.

## Установка

Добавьте строку в Gemfile приложения:

    gem 'typefactory', '0.0.1'

После выполните: `bundle install`

## Использование

Гему потребуется файл инициализации, содержащий ряд настроек. Стандартную версию файла можно сгенерировать командой `rails generate typefactory config`

После этого в объектах класса String можно использовать метод `typeit`. 
    
    <%= @product.description.typeit %>
    'Какой-то "странный" текст, "наборанный "кириллицей""'.typeit

## Contributing

1. Fork it ( https://github.com/eboyko/typefactory/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new pull request
