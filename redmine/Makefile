rake:
	service postgresql start

	# create database
	sudo -u postgres psql -c "CREATE USER redmine WITH PASSWORD 'redmine';"
	sudo -u postgres createdb -E UTF-8 -O redmine -T template0 redmine

	# redmine
	cd /var/lib/redmine/;sudo -u www-data bundle exec rake generate_secret_token
	cd /var/lib/redmine/;sudo -u www-data RAILS_ENV=production bundle exec rake db:migrate
	# plugins
	cd /var/lib/redmine/;sudo -u www-data RAILS_ENV=production NAME=redmine_scm bundle exec rake redmine:plugins:migrate
	cd /var/lib/redmine/;sudo -u www-data RAILS_ENV=production NAME=redmine_backlogs bundle exec rake redmine:plugins:migrate
	cd /var/lib/redmine/;sudo -u www-data RAILS_ENV=production NAME=redmine_issue_templates bundle exec rake redmine:plugins:migrate
	cd /var/lib/redmine/;sudo -u www-data RAILS_ENV=production NAME=redmine_code_review bundle exec rake redmine:plugins:migrate
	cd /var/lib/redmine/;sudo -u www-data RAILS_ENV=production NAME=clipboard_image_paste bundle exec rake redmine:plugins:migrate
	cd /var/lib/redmine/;sudo -u www-data RAILS_ENV=production NAME=redmine_xls_export bundle exec rake redmine:plugins:migrate

	service postgresql stop