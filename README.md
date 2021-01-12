# KeeWeb WebDAV
KeeWeb with a WebDAV server. Useful for small teams.

This container is perfect for small teams. It will automatically fetch the KeePass Database from a WebDAV folder. This folder is protected by a username/password. Only the master password is asked since the username/password of the WebDAV folder are supplied to KeeWeb app. This way a KeePass Database can be shared easily while retaining the main advantage of KeePass. The database can be read even if the server is down. As long as you have the file and the master password.
## Limitations
There are a few limitations regarding the security of this application. For a small team, the security might be enough. However, some important details must be kept in mind.

- Any user who has access to the port exposed by this container is considered a trusted user. See below oauth2-proxy to improve the access and control of this application.
- Any user can download the KeePass Database.
- A common password or key must be shared to unlock the KeePass Database.
- The username/password of the WebDAV are exposed in the /config.json file.
- TLS should be added by a reverse proxy such as Nginx or Traefik.

## OAuth2-proxy
OAuth2-proxy acts like a reverse proxy. It is useful to add access and control to an existing application. In this case, we will use it to forward the authenticated connections to the KeeWeb/WebDAV container. The file `docker-compose-oauth2.yml` contains an example with a setup with oauth2-proxy.

## Variables
Some variables must be set to use the container.
| Variable        | Description           |
| ------------- |-------------|
| `WEBDAV_USERNAME` | Username used to access the WebDAV folder |
| `WEBDAV_PASSWORD` | Password used to access the WebDAV folder |
| `WEBDAV_NAME` | Name of the KeePass Database. Will be shown in the KeeWeb interface |
| `WEBDAV_HOSTNAME` | Hostname of the WebDAV server. Must be the same hostname that is used to access the KeeWeb application. If not some issues might arise with CORS.  |
| `WEBDAV_FILE` | Filename of the KeePass Database. Example file.kdbx |
| `WEBDAV_SSL` | (Optional) set to false if KeeWeb should be used over http without a reverse proxy. |


## Volume
A volume must be set in order for the container to have persistent storage for the KeePass Database. The following path should be mapped to a volume. 

- `/usr/share/nginx/html/webdav`