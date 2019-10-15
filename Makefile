prepare:
	docker-compose -f docker/docker-compose.yml pull rails
	docker-compose -f docker/docker-compose.yml run rails sh -c "yarn install && bundle install"
	docker-compose -f docker/docker-compose.yml run rails sh -c "bin/rails db:setup"

build:
	docker build -f docker/Dockerfile -t it52/rails:latest --cache-from it52/rails:latest .

lint:
	docker-compose -f docker/docker-compose.yml run rails sh -c "bin/rubocop && yarn run lint"

rspec:
	docker-compose -f docker/docker-compose.yml run rails sh -c "bundle exec rspec"

test: lint rspec

build_prod:
	docker build -f docker/Dockerfile.production -t it52/rails:production --build-arg RAILS_MASTER_KEY --cache-from it52/rails:production .

