#!/usr/bin/env bash

source ./.env
if [[ "$1" == '--dev' ]]; then
  source ./.env.dev
fi

chmod +x redbean.com

if [[ "$HMR" = true ]]; then
  echo 'Hot module reload enabled! Listening for file changes...'
  ./redbean.com -v -l $LISTEN -p $PORT &
  a=''
  while true; do
    b=$(ls -l $FILES)
    if [[ $a != $b ]]; then
      a=$b
      pkill -P $$
      zip redbean.com $FILES
      ./redbean.com -v -l $LISTEN -p $PORT &
    fi
    sleep 1
  done
else
  ./redbean.com -v -l $LISTEN -p $PORT
fi
