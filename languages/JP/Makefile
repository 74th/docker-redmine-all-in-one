rake:
	service mysql start

	cd /var/lib/redmine/;sudo -u www-data RAILS_ENV=production REDMINE_LANG=ja bundle exec rake redmine:load_default_data
	cd /var/lib/redmine/;sudo -u www-data RAILS_ENV=production REDMINE_LANG=ja bundle exec rake redmine:backlogs:install task_tracker=サポート story_trackers=機能 labels=false
	
	mysql -u root -predmine -e "UPDATE trackers SET name='タスク' WHERE name='サポート';" redmine
	mysql -u root -predmine -e "UPDATE  issue_statuses SET name='レビュー' WHERE name='解決';" redmine
	service mysql stop
