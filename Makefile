deps:
	sudo ansible-galaxy install -p cm/roles zzet.postgresql --ignore-errors

install:
	ansible-playbook -i cm/inventory cm/playbook.yml -K
	gem install bundler
	bundle install
	rake db:create db:migrate db:seed

develop:
	rake db:dev_init
	rails s

up:
	git pull --rebase && bundle && rake db:migrate db:seed

deploy:
	ansible-playbook -i cm/inventory cm/deploy.yml

.PHONY: install up deps develop deploy
