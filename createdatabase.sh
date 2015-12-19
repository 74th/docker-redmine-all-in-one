service postgresql start
sudo -u postgres psql -c "CREATE USER redmine WITH PASSWORD 'redmine';"
sudo -u postgres createdb -E UTF-8 -l ja_JP.UTF-8 -O redmine -T template0 redmine
service postgresql stop
