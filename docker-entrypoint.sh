#!/bin/sh

if [ -f tmp/pids/server.pid ]; then
    rm tmp/pids/server.pid
fi

rails db:setup
rails db:migrate

rails server -p 3000 -b '0.0.0.0'
