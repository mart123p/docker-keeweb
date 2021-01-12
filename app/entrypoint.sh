#!/bin/sh
set -e

cp /usr/share/nginx/config.json /usr/share/nginx/html/config.json

env_variables="WEBDAV_USERNAME WEBDAV_PASSWORD WEBDAV_NAME WEBDAV_HOSTNAME WEBDAV_FILE"
for env_var in $env_variables
do
    env_value=$(eval "echo \$$env_var")
    if [ -z "$env_value" ]; then
        echo "$env_var: Is not set you must set the variable in order to execute the container"
        exit 1
    fi
    sed -i "s/$env_var/$env_value/g" /usr/share/nginx/html/config.json
done

if [ -z "$WEBDAV_SSL" ]; then
    WEBDAV_SSL="https"
elif [ "$WEBDAV_SSL" = "false" ]; then
    WEBDAV_SSL="http"
else
    WEBDAV_SSL="https"
fi
sed -i "s/WEBDAV_SSL/$WEBDAV_SSL/g" /usr/share/nginx/html/config.json
sed -i "s/(no-config)/config.json/g" /usr/share/nginx/html/index.html

chown -R nginx:nginx /usr/share/nginx/html/webdav/
# Set the password file used for nginx
htpasswd -cbB /etc/nginx/htpasswd.webdav "$WEBDAV_USERNAME" "$WEBDAV_PASSWORD"

exec "$@"
