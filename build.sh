#!/usr/bin/env sh

files='index.html api.lua .init.lua'

curl https://redbean.dev/redbean-latest.com >redbean.com
zip redbean.com $files
