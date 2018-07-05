#! /bin/bash

set -e

RESUME_ONLINE_THEME=paper
RESUME_PDF_THEME=paper

build_jekyll() {
  bundle install
  cat << EOF > _config.ci.yml
version: $CI_COMMIT_SHA
analytics: $GA_ID
EOF
  bundle exec jekyll build -d jpgenovese --config _config.yml,_config.ci.yml
}

build_resume() {
  pushd ./resume
  npm install jsonresume-theme-$RESUME_ONLINE_THEME
  npm install jsonresume-theme-$RESUME_PDF_THEME
  hackmyresume build ./resume.json TO out/resume.html -t node_modules/jsonresume-theme-$RESUME_ONLINE_THEME
  hackmyresume build ./resume.json TO out/resume.pdf --pdf wkhtmltopdf -t node_modules/jsonresume-theme-$RESUME_PDF_THEME
  hackmyresume analyze ./resume.json > out/resume.stats
  cat out/resume.stats
  popd
}

build_jekyll
build_resume