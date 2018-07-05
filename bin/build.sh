#! /bin/bash

set -e

RESUME_ONLINE_THEME=paper
RESUME_PDF_THEME=paper
OUTPUT_DIR="../output"

build_jekyll() {
  pushd ./site
  bundle install
  cat << EOF > _config.ci.yml
version: $CI_COMMIT_SHA
analytics: $GA_ID
EOF
  bundle exec jekyll build -d $OUTPUT_DIR/jpgenovese --config _config.yml,_config.ci.yml
  popd
}

build_resume() {
  pushd ./resume
  npm install jsonresume-theme-$RESUME_ONLINE_THEME
  if [[ "$RESUME_ONLINE_THEME" != "$RESUME_PDF_THEME" ]]
  then 
    npm install jsonresume-theme-$RESUME_PDF_THEME
  fi
  hackmyresume build ./resume.json TO $OUTPUT_DIR/resume/resume.html -t node_modules/jsonresume-theme-$RESUME_ONLINE_THEME
  hackmyresume build ./resume.json TO $OUTPUT_DIR/resume/resume.pdf --pdf wkhtmltopdf -t node_modules/jsonresume-theme-$RESUME_PDF_THEME
  hackmyresume analyze ./resume.json > $OUTPUT_DIR/resume/resume.stats
  cat ../output/resume/resume.stats
  popd
}

mkdir -p $OUTPUT_DIR

build_jekyll
build_resume