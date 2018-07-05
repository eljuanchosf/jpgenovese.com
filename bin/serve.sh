#! /usr/bin/env bash

export CI_COMMIT_SHA=my-sha
export GA_ID=my-ga-id

OUTPUT_DIR="../output"

mkdir -p $OUTPUT_DIR

pushd ./site
cat << EOF > _config.ci.yml
version: "$CI_COMMIT_SHA"
analytics: "$GA_ID"
EOF
jekyll serve -w -H 127.0.0.1 -P 4000 -o -l -d $OUTPUT_DIR/jpgenovese --config _config.yml,_config.ci.yml
popd