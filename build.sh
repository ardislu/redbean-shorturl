#!/usr/bin/env bash

source ./.env
if [[ "$1" == '--dev' ]]; then
  source ./.env.dev
fi

curl https://redbean.dev/redbean-latest.com >redbean.com
zip redbean.com $FILES
