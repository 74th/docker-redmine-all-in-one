rake:
	service mysql start

	# create database
	mysql -u root -predmine -e "CREATE DATABASE redmine DEFAULT CHARACTER SET utf8;"

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

	service mysql stop