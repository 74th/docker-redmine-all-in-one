service postgresql start
cd /var/lib/redmine/
sudo -u www-data bundle exec rake generate_secret_token
sudo -u www-data RAILS_ENV=production bundle exec rake db:migrate
sudo -u www-data RAILS_ENV=production bundle exec rake redmine:plugins:migrate RAILS_ENV=production NAME=redmine_scm
sudo -u www-data RAILS_ENV=production bundle exec rake redmine:plugins:migrate RAILS_ENV=production NAME=redmine_backlogs
#sudo -u www-data RAILS_ENV=production REDMINE_LANG=ja bundle exec rake redmine:load_default_data
service postgresql stop
