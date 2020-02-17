PROJECT_HOME="$(shell pwd)"

.PHONY= build run unit

run:
	docker-compose up --build -d

unit:
	docker exec store-api bundle exec rspec
