#! /bin/bash

bundle install
cat << EOF > _config.ci.yml
version: $CI_COMMIT_SHA
analytics: $GA_ID
EOF
bundle exec jekyll build -d jpgenovese --config _config.yml,_config.ci.yml