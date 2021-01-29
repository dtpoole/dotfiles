#!/bin/bash

if [ -f /etc/timezone ]; then
    TZ=$(cat /etc/timezone)
elif [ -f /etc/localtime ]; then
    TZ=$(ls -la /etc/localtime | cut -d/ -f8-9)
else
    TZ=UTC
fi

docker run \
    --env TZ=${TZ} \
    -it dtpoole/dev
