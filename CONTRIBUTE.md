# ALL HAIL CONTRIBUTORS!

Тут мы расскажем как настроить свой компьютер для запуска проекта локально и как правильно оформить pull request со своими исправлениями.
Если вы знакомы со стэком Ruby on Rails, то первую часть можно не читать.

Да, про API можно почитать [здесь](http://www.it52.info/apidoc/v1.html)

## Настраиваем стэк

На всякий случай мы приведём два способа настройки необходимого стэка: с помощью традиционных средств и с помощью виртуальной машины.

*Необходимое для запуска ПО*

* Ruby 2.2.1
* PostgreSQL 9.3+
* node.js
* git

*Библиотеки*

* libmagick++-dev
* imagemagick
* libpq-dev

Также вам потребуется аккаунт на [GitHub](https://github.com).

### Работа с репозиторием

С репозиторием проекта мы будем работать следующим образом.

1. Создаём форк репозитория в своём аккаунте Github.
Переходим на страницу репозитория [NNRUG/it52-rails](https://github.com/NNRUG/it52-rails) и форкаем проект к себе.
![Форкаем проект](http://take.ms/UOfFV)

2. Клонируем репозиторий из своего аккаунта
`$ git clone git@github.com:ВАШ_ЛОГИН/it52-rails.git`

3. Переходим в папку проекта
`$ cd it52-rails`

4. Переходим на нужную ветку
`$ git checkout hackathon-2015-05`

Все изменения можно и нужно вносить в ветку `hackathon-2015-05`. Если хотите попробовать успеть сделать несколько фич, то крайне желательно завести ветку под каждую из них.
В любом случае все pull request необходимо будет выставлять к ветке `hackathon-2015-05` оригинального репозитория. Более подробно про работу с PR можно почитать в [хелпе Github](https://help.github.com/articles/using-pull-requests/).

### Ручная настройка

1. Ставим [rvm](https://rvm.io/) и [ruby](http://www.ruby-lang.org/en/) нужной версии
```
$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
$ \curl -sSL https://get.rvm.io | bash -s stable
$ rvm install 2.2.1 --autolibs=4
```

2. Создаём в postgres базу и пользователя
```
$ sudo -u postgres createdb it52_rails_dev
$ sudo -u postgres createuser --superuser $USER
```

3. Клонируем репозиторий

### Образ для Vagrant

1. Ставим [virtualbox](https://www.virtualbox.org/wiki/Downloads).
2. Ставим [vagrant](https://www.vagrantup.com/downloads.html).
3. Клонирем репозиторий.
4. Запускаем `vagrant up` в папке проекта.

Для перехода в папку проекта внутри виртуальной машины нужно сделать следующее.
```
$ vagrant ssh
$ cd /vagrant
```
Все дальнейшие инструкции, где упоминается папка проекта, должны выполняться там.
При этом вы можете использовать привычный редактор для изменения файлов на компьютере-хосте, но для любителей в виртуальной машине установлен `vim`. :smirk:

## Запуск

Для начала работы с проектом нужно создать конфигурационые файлы на основе шаблонов:

    cd /vagrant
    cp config/database.yml.template config/database.yml
    cp config/secrets.yml.template config/secrets.yml
    cp config/application.yml.template config/application.yml

После этого необходимо изменить настройки подключения к БД в файле `config/database.yml` в том случае, если вы решили настроить локальный стэк. Если вы используете виртуалку, то мы всё уже настроили за вас.

Установить зависимости, создать, мигрировать и засеять БД:

    gem install bundler
    bundle install
    bundle exec rake db:setup

Запустить rails-сервер:

    unicorn_rails

Скрестить пальцы и открыть страницу `http://192.168.100.10:8080/` — для установки с помощью Vagrant, `localhost:8080` — для локальной конфигурации.
Админский доступ доступен для пользователя `admin@it52.info` с паролем `12345678`.
