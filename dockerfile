FROM library/centos
MAINTAINER 74th<site@j74th.com>

# http://blog.redmine.jp/articles/3_2/install/centos/

# yum
RUN yum -y groupinstall "Development Tools"
RUN yum -y install openssl-devel readline-devel zlib-devel curl-devel libyaml
RUN yum -y install openssl-devel readline-devel zlib-devel curl-devel libyaml-devel libffi-devel
RUN yum -y install postgresql-server postgresql-devel
RUN yum -y install httpd httpd-devel
RUN yum -y install ImageMagick ImageMagick-devel ipa-pgothic-fonts

# ruby
ADD https://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.gz /root/
WORKDIR /root/
RUN tar xvf ruby-2.2.3.tar.gz
WORKDIR /root/ruby-2.2.3
RUN sh -c ./configure --disable-install-doc
RUN make
RUN make install
RUN gem install bundler --no-rdoc --no-ri

# postgresql
# TODO password
RUN sudo -u postgres createuser -P redmine
RUN sudo -u postgres createdb -E UTF-8 -l ja_JP.UTF-8 -O redmine -T template0

# Redmine
RUN svn co http://svn.redmine.org/redmine/branches/3.2-stable /var/lib/redmine
ADD databade.yml /var/lib/redmine
ADD configuration.yml /var/lib/redmine

WORKDIR /var/lib/redmine
RUN bundle install --without development test --path vendor/bundle