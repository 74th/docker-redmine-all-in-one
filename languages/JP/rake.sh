service postgresql start

sudo -u www-data RAILS_ENV=production REDMINE_LANG=ja bundle exec rake redmine
// TODO backlogs

service postgresql stop
