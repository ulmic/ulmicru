```shell
git clone git@github.com:ulmic/ulmicru.git
cd ulmicru
bundle
cp config/database.yml.sample config/database.yml
/* CREATE ROLE IN PG */
rake db:create db:migrate db:seed
cp config/secrets.yml.sample config/secrets.yml
/* ASK oauth.yml WITH REAL KEYS */
cp config/oauth.yml.sample config/oauth.yml
rails s
```
