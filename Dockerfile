FROM library/ubuntu
MAINTAINER 74th<site@j74th.com>

# http://blog.redmine.jp/articles/3_2/install/centos/

RUN locale-gen ja_JP.UTF-8

RUN apt-get update
RUN apt-get install -y build-essential zlib1g-dev libssl-dev libreadline-dev libyaml-dev libcurl4-openssl-dev
RUN apt-get install -y postgresql postgresql-server-dev-9.3
RUN apt-get install -y apache2-mpm-worker apache2-threaded-dev libapr1-dev libaprutil1-dev
RUN apt-get install -y imagemagick libmagick++-dev fonts-takao-pgothic
RUN apt-get install -y subversion git
RUN apt-get install -y software-properties-common
RUN apt-add-repository ppa:brightbox/ruby-ng
RUN apt-get update
RUN apt-get install -y ruby2.2
RUN apt-get install -y ruby2.2-dev
RUN gem install bundler

# Redmine
RUN svn co http://svn.redmine.org/redmine/branches/3.2-stable /var/lib/redmine
ADD config/* /var/lib/redmine/config/

# postgresql
ADD createdatabase.sh /root/
RUN sh /root/createdatabase.sh

WORKDIR /var/lib/redmine
RUN bundle install --path vendor/bundle
ADD rake.sh /var/lib/redmine/
RUN sh /var/lib/redmine/rake.sh
# RUN sudo -u www-data bundle exec rake generate_secret_token
# RUN sudo -u www-data RAILS_ENV=production bundle exec rake db:migrate
# RUN sudo -u www-data RAILS_ENV=production REDMINE_LANG=ja bundle exec rake redmine:load_default_data
RUN gem install passenger --no-rdoc --no-ri
RUN passenger-install-apache2-module --auto

# apache2
RUN apt-get install libapache2-svn
ADD apache2/redmine.conf /etc/apache2/conf-available/
RUN passenger-install-apache2-module --snippet >> /etc/apache2/conf-available/redmine.conf
RUN sed -i -e 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/lib\/redmine\/public/g' /etc/apache2/sites-enabled/000-default.conf
RUN a2enconf redmine
RUN apache2ctl configtest

EXPOSE 80
ADD entrypoint.sh /root/
WORKDIR /root/

# svn

ENTRYPOINT sh /root/entrypoint.sh
