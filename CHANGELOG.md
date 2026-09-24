# Changelog

## [Unreleased]

* Updated every Edgeapp to its latest stable upstream release (verified live).
* Immich v3.2.2, Vaultwarden 1.37.3, Nextcloud 34.0.4, Jellyfin 10.11.11.
* Ghost 6.64.0, Odoo 19.0, NocoDB 2026.08.2, Paperless-ngx 3.1.3.
* Planka 2.2.1, Listmonk v6.2.0, Siyuan v3.8.3, Umami 3.3.1.
* Rocket.Chat 7.13.9 (MongoDB 5.0 kept; 8.x+mongo8 deferred).
* Gitea 1.27.2, n8n 2.40.0, WordPress 7.1.0, Uptime Kuma 2.5.3.
* Actual 26.9.0, Linkwarden v2.16.1, FreshRSS 1.29.1, Calibre-web 0.6.27.
* Code-server 4.135.0, Jupyter on official base-notebook, Collabora (digest-pinned).
* Matrix Conduit v0.10.13 (security fix), PocketBase 0.40.3, Tandoor 2.6.14.
* Invidious (digest-pinned), LimeSurvey 7, Ghost, NocoDB, Traggo 0.8.3, Webrcade 0.2.3.
* Campfire pinned 1.4.9, Writebook pinned 1.2.2, Fizzy storage fix, Podgrab proxy port.
* Filebrowser pinned to final v2.63.23 (upstream archived) with persistent database.
* Focalboard packaged at 7.10.0 (upstream unmaintained; marked deprecated).
* Appsmith v2.3 (needs ~2GB RAM; not for 8GB shared hosts).
* Fixed first-boot permission handling (odoo, codeserver, fizzy, filebrowser),
  proxy ports (planka 1337, freshrss 80, limesurvey, tandoor ALLOWED_HOSTS),
  and broken compose definitions (limesurvey image/DB, tandoor vhost).

## [1.4.0] - 23-09-2026

* Added Campfire, Collabora, Fizzy, Hello, Memos, Rocket.Chat, and Writebook.
* Migrated app development scripts to Docker Compose v2.
* Updated Immich to v3.1.0 with matching machine learning, Valkey, and VectorChord services.
* Updated Vaultwarden to 1.37.2.
* Fixed Campfire operation behind the Edgebox SSL-terminating proxy.

## [1.3.0] - 05-12-2020

* Added new Edgeapp: Syncthing
* Added the ability to run Edgeapps in local development without any other dependencies than Docker Compose:
    * Added relevant scripts to build, clean, run, stop and get a local development app status the .scripts directory
    * Added a Makefile to run the scripts with simple commands
* Added the ability to bootstrap new apps via templates:
    * Added Make command to create a new Edgeapp, run `make app` and follow the instructions
    * Added the .templates directory
    * Added the base "hello" template for creating new Edgeapps
    * Added .scripts/bootstrap.sh tooling to handle logic of cloning a template into a new Edgeapp
* Added Browser Dev Environment Support to some Edgeapps (syncthing) by providing a .vscode/tasks.json file.

### Missing Past Releases

Release notes for past versions are not available in this file. Please refer to the [GitHub releases](https://hithub.com/edgebox-iot/apps/releases) for more information. Feel free to contribute to this file by adding missing release notes.
