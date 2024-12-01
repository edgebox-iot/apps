![Edgebox Logo Image](https://adm-listmonk.edgebox.io/uploads/logo_transparent_horizontal_300x100.png)
# apps

App package and container definitions (EdgeApps) for Edgebox.
Curious about what the Edgebox is? Check out our [website](https://edgebox.io)!

## Installation

This repository should automatically be installed on the Edgebox system setup repository for the target Edgebox platform (`multipass-cofig`, `ua-netinst-config`, `image-builder`)
In this case, it will be located in `/home/system/components/apps`.

If you have a custom Edgebox setup, or for detached usage, you can install this repository manually by running the following commands:
```bash
cd /home/system/components/
git clone https://github.com/edgebox-iot/apps.git
```

## Using for Local Development

### Makefile

This repository features a `make` command to aid running edgeapps in local development mode, and adding configuration to them.

### Running apps

To build and run one of the apps, you can run the following command:

```bash
make run apps="<app_folder_name>"
```

This will build the app container and run it in the background. You can then access the app by visiting `http://<app_folder_name>.local` in your browser.

### Building apps

To just build the app images (but not run them), you can run the following command:

```bash
make build apps="<app_folder_name>"
```

### Stopping apps and services.

To stop certain services, you can run the following command:

```bash
make stop services="<service_name>"
```

This will stop the specified service if you provide the `services` argument. Otherwise, it will stop all app services.

### Environment Variables

You can add environment variables to configure the local environeent by creating a `.env` file in the root of the app folder. This file should contain the environment variables you want to set, in the format `KEY=VALUE`. Check the `.env.example` file in the app folder for an example. Here's the list of environment variables you can set:

- `ACTIVE_APPS`: A space-separated list of app folder names to run by default. This allows you to use the make commands without having to pass any arguments. For example, `ACTIVE_APPS=umami gitea` will run the `umami`, `gitea` apps when you run `make run`, build them when you run `make build`, and stop them when you run `make stop`.
- `HOST_PORT`: The port to run the apps on. This is useful if you want to run these apps on a specific port. For example, `HOST_PORT=8080` will run apps on port 8080. By default, apps run on port 80.

## Using with edgebox-iot/ws

This repository is not intended to be used standalone except for local edgeapps development. Instead, it is leveraged by the [ws repository](https://github.com/edgebox-iot/ws) to build and manage the application containers with a set of opinionated configurations and aligned features to host live. This predictability allows a working edgebox system to host all these apps with minimal to no configuration on the user side, while being reliable to run and maintain on a live configuration.

To run these apps, you need to run the following command at **the root of the [ws repository](https://github.com/edgebox-iot/ws)**.
```bash
$ ./ws -b
```
> To use WS to build these applications manually without a properly working Edgebox system (that includes the `api` and `edgeboxctl`), you need to manually set the desired environment and lock files for each app prior to starting the build process, otherwise it will not work as expected. Check below for more details on manual configuration of apps 👇

This will go through each folder in the `/home/system/components/apps/` folder, and configure the containers for each valid app entry. 
After running this command, You should have a `docker-compose.yml` file in the the root of the ws repository (it is git igored) with the final generated configuration which will then be used to spawn the containers via the `docker-compose up -d` command.
The containers will also automatically start, and be available on the configured `VIRTUAL_HOST` of each app, given you've also setup all the necessary dependencies for `ws`.

Check the [ws repository](https://github.com/edgebox-iot/ws) for more information on how `ws` works.


## Edgeapp Templates

 This repository also contains a set of edgeapp templates that can be used to scaffold new edgeapps. These templates are located in the `./.templates/` directory. A companion script `./.templates/bootstrap.sh` is provided to help you create a new edgeapp from a template.

Run the following command to create your new app:
```bash
make app template=<template-name> app_slug="<app_slug>" app_name="<app_name>" app_description="<app_description>" has_options="<yes|no>"
```

All the arguments are optional but important for your new app. Here's some context on each argument:

- `<template_name>`: The name of the template to use. This should be the name of a directory in the `./.templates/` directory. Current available templates are:
  - `hello`: A simple edgeapp that demonstrates how to create an edgeapp that runs "Hello World" when accessed.
- `<app_slug>`: The slug of the app. This will be used as the directory name for the new app. It should be a unique identifier for the app and only use the characters `a-z`, `0-9`, and `-`.
- `<app_name>`: The name of the app. This will be used as the display name for the app. Example: `Syncthing`
- `<app_description>`: A short description of the app. This will be used as the description for the app. Example: `Sync Filesystem`
- `<has_options>`: A `yes` or `no` value indicating if the app has options. This will be used to determine if the app should have a configuration page in the dashboard. Default: `no`. If `yes`, it will include the necessary example configuration file in the new app.

For example, to create a new app called `syncthing` from the `hello` template, you would run:
```bash
make app app_slug="syncthing" app_name="Syncthing" app_description="Sync Filesystem" has_options="no"
```
or
```bash
./.templates/bootstrap.sh hello syncthing Syncthing "Sync Filesystem" no
```

This will create a new app in the `./apps/` directory with the slug `syncthing` and the name `Syncthing` that uses the `hello` (default) template as a base. You can then customize the app as needed (change the Dockerfile, add more services, environment variables, build and install assets, etc).
