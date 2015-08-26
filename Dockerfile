FROM ruby:2.2.1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ENV RAILS_ENV production
ENV REFILE_CACHE_DIR /var/tmp/uploads

RUN curl -sL https://deb.nodesource.com/setup | bash -

RUN apt-get update -qq \
    && apt-get install -yqq apt-transport-https libxslt-dev libxml2-dev nodejs imagemagick

RUN echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 \
    && apt-get update -qq \
    && apt-get install -qqy lxc-docker-1.5.0

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

RUN bundle install --without development test

COPY . /usr/src/app
