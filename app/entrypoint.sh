#!/bin/sh
set -e

cp /usr/share/nginx/config.json /usr/share/nginx/html/app/config.json

env_variables="WEBDAV_NAME WEBDAV_FILE"
for env_var in $env_variables
do
    env_value=$(eval "echo \$$env_var")
    if [ -z "$env_value" ]; then
        echo "$env_var: Is not set you must set the variable in order to execute the container"
        exit 1
    fi
    sed -i "s/$env_var/$env_value/g" /usr/share/nginx/html/app/config.json
done

sed -i "s/(no-config)/\/app\/config.json/g" /usr/share/nginx/html/app/index.html

chown -R nginx:nginx /usr/share/nginx/html/webdav/

exec "$@"
