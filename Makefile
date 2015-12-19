build:
	docker build -t 74th/redmine-all-in-one .
run:
	docker run -d -p 80:80 74th/redmine-all-in-one
