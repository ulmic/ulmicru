```shell
git clone git@github.com:ulmic/ulmicru.git
cd ulmicru
bundle
/* CREATE ROLE mic IN PG */
rake db:create db:migrate
cp config/secrets.yml.sample config/secrets.yml
cp config/oauth.yml.sample config/oauth.yml
rails s
```
