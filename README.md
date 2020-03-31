# Тайпфектори

Этот небольшой плагин поможет вам подготовить тексты к публикации в вебе. Тайпфектор разрабатывался для русского языка, но может быть легко адаптирован для других языков (к примеру, для англо-германской группы).

_Тайпфектори — мой первый гем и я буду благодарен за любую критику_

## Возможности

Текущая версия расставляет:
* правильные многоуровневые кавычки;
* неразрывные пробелы после коротких слов;
* длинные тире.


## Установка

### Ruby on rails

	$ gem "typefactory", "~> 0.0.20"
	$ bundle install
	

### Метод в классе String

Тайпфектори добавляет метод `prepare` в стандартный класс `String`, который вы также можете использовать:

	'Правильно "оформленный" в вебе текст'.prepare
	<%= @description.prepare %>


## Настройка

Сгенерируйте шаблон файла настроек:

	$ rails generate typefactory config
	
Отредактируйте параметры в файле `config/initializers/typefactory.rb` по своему усмотрению

## Помогите улучшить

Если вы нашли ошибку в работе алгоритма, пришлите исходный текст по электронной почте: eboyko@eboyko.ru

## Contribute

1. Fork it https://github.com/eboyko/typefactory/fork
2. Create your feature branch `git checkout -b my-new-feature`
3. Commit your changes `git commit -am 'Add some feature'`
4. Push to the branch `git push origin my-new-feature`
5. Create a new pull request

