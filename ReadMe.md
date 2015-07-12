[![Build Status](https://travis-ci.org/ulmic/ulmicru.svg?branch=develop)](https://travis-ci.org/ulmic/ulmicru) [![Coverage Status](https://coveralls.io/repos/ulmic/ulmicru/badge.svg?branch=feature%2Ffix_travis_tests)](https://coveralls.io/r/ulmic/ulmicru?branch=feature%2Ffix_travis_tests) [![Code Climate](https://codeclimate.com/github/ulmic/ulmicru/badges/gpa.svg)](https://codeclimate.com/github/ulmic/ulmicru)
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

access admin panel in dev
```ruby
u = User.first
u.role = :admin
u.save
100.times { n = News.first.dup; n.save }
```
