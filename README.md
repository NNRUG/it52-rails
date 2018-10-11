# Сайт нижегородского IT-сообщества

[![Build Status](https://travis-ci.org/NNRUG/it52-rails.svg?branch=it52)](https://travis-ci.org/NNRUG/it52-rails)
[![Code Climate](https://codeclimate.com/github/NNRUG/it52-rails/badges/gpa.svg)](https://codeclimate.com/github/NNRUG/it52-rails)
[![Test Coverage](https://codeclimate.com/github/NNRUG/it52-rails/badges/coverage.svg)](https://codeclimate.com/github/NNRUG/it52-rails)

## Main branch

Main branch is [it52](https://github.com/NNRUG/it52-rails/tree/it52)

## Getting started

Для начала работы с проектом нужно создать конфигурационые файлы на основе шаблонов:

    cp config/database.yml.template config/database.yml
    cp config/secrets.yml.template config/secrets.yml
    cp config/application.yml.template config/application.yml

Установить зависимости, создать и мигрировать БД:

    bundle install
    bundle exec rake db:setup

Запустить rails-сервер:

    unicorn_rails

## Style guides

- [Ruby](https://github.com/bbatsov/ruby-style-guide)
- [Rails](https://github.com/bbatsov/rails-style-guide)
- [Formatting](https://github.com/thoughtbot/guides/tree/master/style#formatting)
- [Naming](https://github.com/thoughtbot/guides/tree/master/style#naming)
- [Testing](https://github.com/thoughtbot/guides/tree/master/style#testing)
- [CoffeeScript](https://github.com/thoughtbot/guides/tree/master/style#coffeescript)
- [Markdown](http://www.cirosantilli.com/markdown-styleguide)

## Requirements

- Ruby 2.2.1
- PostgreSQL 9.x

## Я хочу помочь!

Всегда пожалуйста. Мы всегда рады хорошим людям. Помочь вы можете разными способами.

**Я нашёл ошибку!** — _Отлично! Напишите нам об этом, [оставив багрепорт](https://github.com/NNRUG/it52-rails/issues)_

**Я придумал новую фичу.** — _Ещё лучше! [Опишите](https://github.com/NNRUG/it52-rails/issues), чего вам не хватает, или что можно реализовать лучше. Обсудим и сделаем._

**Я гуру (начинающий/хочу изучить) Ruby on Rails, и у меня есть немного времени.** — _Круто! Присылайте pull request. Только про тесты не забудьте._

**Я не умею программировать, но умею рисовать.** — _Хороший дизайнер всегда пригодится. Мы будем безмерно благодарны за красивый логотип для ресурса. Если найдёте время причесать дизайн, то совсем хорошо. Логотип обсуждаем на [этой странице](https://github.com/NNRUG/it52-rails/issues/7)._

## Спасибо

* Коллегам из Ростова — [оригинальный репозиторий на GitHub](https://github.com/vtambourine/it61-rails)
* Всем [разработчикам, внёсшим посильный вклад](https://github.com/NNRUG/it52-rails/graphs/contributors).
