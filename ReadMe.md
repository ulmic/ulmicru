[![Build Status](https://travis-ci.org/ulmic/ulmicru.svg?branch=develop)](https://travis-ci.org/ulmic/ulmicru) [![Coverage Status](https://coveralls.io/repos/ulmic/ulmicru/badge.svg?branch=feature%2Ffix_travis_tests)](https://coveralls.io/r/ulmic/ulmicru?branch=feature%2Ffix_travis_tests) [![Code Climate](https://codeclimate.com/github/ulmic/ulmicru/badges/gpa.svg)](https://codeclimate.com/github/ulmic/ulmicru)

### Install

```shell
make deps
make install
rails generate react_webpack_rails:install --no-example --no-hot-reload --no-server-side --no-karma-setup --redux --skip
# Do not overwrite index.js !!!
```

### Run server

```shell
make develop
```


Fill avatars on localhost via console

```ruby
Member.update_all(avatar: File.open("#{Rails.root}/public/logo.png"))
```
