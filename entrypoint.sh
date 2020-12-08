#!/bin/bash

rm -rf /usr/src/app/tmp/pids/server.pid
bundle exec rake db:create db:migrate
bundle exec rails s
