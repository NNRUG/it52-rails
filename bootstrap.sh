#!/usr/bin/env bash

echo "Provisioning virtual machine..."

# PPA
# if [ ! -f "/etc/apt/sources.list.d/pgdg.list" ]; then
#     echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list
# fi

apt-get install -y curl

curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash -

apt-get install -y htop vim git most wget curl build-essential libssl-dev libmagick++-dev imagemagick postgresql-9.3 libpq-dev nodejs libreadline6-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake bison libffi-dev zsh

locale-gen ru_RU.UTF-8

# Init DB
sudo -u postgres createdb it52_rails_dev
sudo -u postgres createuser --superuser vagrant

# Install RVM & Ruby
su - vagrant -c "chsh -s /bin/zsh"
su - vagrant -c "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"
su - vagrant -c "\curl -sSL https://get.rvm.io | bash -s stable"
su - vagrant -c "rvm install 2.2.1 --autolibs=4"

su - vagrant -c "source /home/vagrant/.rvm/scripts/rvm && cd /vagrant && gem install rake bundler"
su - vagrant -c "source /home/vagrant/.rvm/scripts/rvm && cd /vagrant && bundle install --retry 4 --jobs 2"
