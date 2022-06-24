#!/usr/bin/env bash

source ./.env
if [[ "$1" == '--dev' ]]; then
  source ./.env.dev
fi

curl https://redbean.dev/redbean-2.0.7.com >redbean.com
zip redbean.com $FILES
