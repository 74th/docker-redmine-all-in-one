rake:
	service mysql start

	cd /var/lib/redmine/;sudo -u www-data RAILS_ENV=production REDMINE_LANG=en bundle exec rake redmine:load_default_data
	cd /var/lib/redmine/;sudo -u www-data RAILS_ENV=production REDMINE_LANG=en bundle exec rake redmine:backlogs:install task_tracker=Support story_trackers=Feature labels=false
	
	mysql -u root -predmine -e "UPDATE trackers SET name='Task' WHERE name='Support';" redmine
	
	service mysql stop
