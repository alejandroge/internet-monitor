#!/bin/sh

export RUBY_MAJOR=3.1
export HOME=/root
export BUNDLE_APP_CONFIG=/usr/local/bundle
export RUBY_VERSION=3.1.2
export PATH=/usr/local/bundle/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export GEM_HOME=/usr/local/bundle
export BUNDLE_SILENCE_ROOT_WARNING=1

cd /app
bundle exec ruby script.rb
