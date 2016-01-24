service postgresql start
# create database
sudo -u postgres psql -c "CREATE USER redmine WITH PASSWORD 'redmine';"
sudo -u postgres createdb -E UTF-8 -l ja_JP.UTF-8 -O redmine -T template0 redmine
# redmine
cd /var/lib/redmine/
sudo -u www-data bundle exec rake generate_secret_token
sudo -u www-data RAILS_ENV=production bundle exec rake db:migrate
# plugins
sudo -u www-data RAILS_ENV=production bundle exec rake redmine:plugins:migrate RAILS_ENV=production NAME=redmine_scm
sudo -u www-data RAILS_ENV=production bundle exec rake redmine:plugins:migrate RAILS_ENV=production NAME=redmine_backlogs
sudo -u www-data RAILS_ENV=production bundle exec rake redmine:plugins:migrate RAILS_ENV=production NAME=redmine_issue_templates
sudo -u www-data RAILS_ENV=production bundle exec rake redmine:plugins:migrate RAILS_ENV=production NAME=redmine_code_review

service postgresql stop
