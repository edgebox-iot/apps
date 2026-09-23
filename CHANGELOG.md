# Changelog

## [Unreleased]

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
