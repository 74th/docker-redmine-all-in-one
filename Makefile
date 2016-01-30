build:
	docker build -t 74th/redmine-all-in-one .
rebuild:
	docker build --no-cache=true -t 74th/redmine-all-in-one .
run:
	docker run -d -p 80:80 --name redmine 74th/redmine-all-in-one
rm:
	docker rm -f redmine
rerun:
	docker rm -f redmine
	docker run -d -p 80:80 --name redmine 74th/redmine-all-in-one
bash:
	docker exec -it redmine bash
pushconf:
	docker cp apache2/redmine.conf redmine:/etc/apache2/conf-available/
push:
	docker build --no-cache=true -t 74th/redmine-all-in-one .
	docker push 74th/redmine-all-in-one
build_jp:
	docker build -t 74th/redmine-all-in-one:JP languages/JP/
rerun_jp:
	docker rm -f redmine
	docker run -d -p 80:80 --name redmine 74th/redmine-all-in-one:JP
build_en:
	docker build -t 74th/redmine-all-in-one:EN languages/EN/
rerun_en:
	docker rm -f redmine
	docker run -d -p 80:80 --name redmine 74th/redmine-all-in-one:EN