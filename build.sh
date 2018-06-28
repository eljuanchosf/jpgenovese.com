#! /bin/bash


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
  npm install jsonresume-theme-flat
  hackmyresume build resume.json TO out/resume.html -t node_modules/jsonresume-theme-flat
  hackmyresume build resume.json TO out/resume.pdf -t node_modules/jsonresume-theme-flat
  hackmyresume analyze resume.json > out/resume.stats
  cat out/resume.stats
  popd
}

build_jekyll
build_resume