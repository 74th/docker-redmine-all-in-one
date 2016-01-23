FROM library/ubuntu:14.04.3
MAINTAINER 74th<site@j74th.com>

# http://blog.redmine.jp/articles/3_2/install/ubuntu/

RUN locale-gen ja_JP.UTF-8

RUN apt-get update
RUN apt-get install -y build-essential zlib1g-dev libssl-dev libreadline-dev libyaml-dev libcurl4-openssl-dev
RUN apt-get install -y postgresql postgresql-server-dev-9.3
RUN apt-get install -y apache2-mpm-worker apache2-threaded-dev libapr1-dev libaprutil1-dev apache2-utils
RUN apt-get install -y imagemagick libmagick++-dev fonts-takao-pgothic
RUN apt-get install -y subversion git libapache2-svn gitweb
RUN apt-get install -y software-properties-common
RUN apt-add-repository ppa:brightbox/ruby-ng
RUN apt-get update
RUN apt-get install -y ruby2.2
RUN apt-get install -y ruby2.2-dev
RUN gem install bundler

# Redmine
RUN svn co http://svn.redmine.org/redmine/branches/2.6-stable /var/lib/redmine
ADD config/* /var/lib/redmine/config/

# postgresql
ADD createdatabase.sh /root/
RUN sh /root/createdatabase.sh
# sudo -u postgres psql -c "CREATE USER redmine WITH PASSWORD 'redmine';"
# sudo -u postgres createdb -E UTF-8 -l ja_JP.UTF-8 -O redmine -T template0 redmine

# redmine

# backlog plugin
# RUN git clone https://github.com/backlogs/redmine_backlogs.git /var/lib/redmine/plugins/redmine_backlogs
WORKDIR /var/lib/redmine
RUN bundle install --path vendor/bundle
ADD rake.sh /var/lib/redmine/
RUN sh /var/lib/redmine/rake.sh
# sudo -u www-data bundle exec rake generate_secret_token
# sudo -u www-data RAILS_ENV=production bundle exec rake db:migrate
# sudo -u www-data RAILS_ENV=production REDMINE_LANG=ja bundle exec rake redmine:load_default_data
RUN gem install passenger --no-rdoc --no-ri
RUN passenger-install-apache2-module --auto


# rake redmine:plugins:migrate RAILS_ENV=production

# apache2
ADD apache2/conf-available/redmine.conf /etc/apache2/conf-available/
ADD apache2/mods-available/dav_svn.conf /etc/apache2/mods-available/
ADD apache2/sites-available/000-default.conf /etc/apache2/sites-available/
RUN passenger-install-apache2-module --snippet >> /etc/apache2/conf-available/redmine.conf
RUN a2enconf redmine
RUN a2enmod cgi alias env
RUN apache2ctl configtest
RUN chown www-data:www-data /var/lib/redmine/log/
# repository
RUN mkdir /var/lib/svn/
RUN chown -R www-data:www-data /var/lib/svn/ /var/lib/git/
EXPOSE 80
ADD entrypoint.sh /root/
WORKDIR /root/
ENTRYPOINT sh /root/entrypoint.sh
