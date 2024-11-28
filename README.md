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

## Usage

This repository is not intended to be used standalone. Instead, it is leveraged by the [ws repository](https://github.com/edgebox-iot/ws) to build and manage the application containers with a set of opinionated configurations and aligned features. This predictability allows a working edgebox system to host all these apps with minimal to no configuration on the user side.

To run these apps, you need to run the following command at **the root of the [ws repository](https://github.com/edgebox-iot/ws)**.
```bash
$ ./ws -b
```
> To use WS to build these applications manually without a properly working Edgebox system (that includes the `api` and `edgeboxctl`), you need to manually set the desired environment and lock files for each app prior to starting the build process, otherwise it will not work as expected. Check below for more details on manual configuration of apps 👇

This will go through each folder in the `/home/system/components/apps/` folder, and configure the containers for each valid app entry. 
After running this command, You should have a `docker-compose.yml` file in the the root of the ws repository (it is git igored) with the final generated configuration which will then be used to spawn the containers via the `docker-compose up -d` command.
The containers will also automatically start, and be available on the configured `VIRTUAL_HOST` of each app, given you've also setup all the necessary dependencies for `ws`.


## Edgeapp Templates

 This repository also contains a set of edgeapp templates that can be used to scaffold new edgeapps. These templates are located in the `./.templates/` directory. A companion script `./.templates/bootstrap.sh` is provided to help you create a new edgeapp from a template.

Run the following command to create your new app:
```bash
./.templates/bootstrap.sh <template-name> <app-slug> <app_name> <app-description> <has-options>
```

- `<template-name>`: The name of the template to use. This should be the name of a directory in the `./.templates/` directory. Current available templates are:
  - `hello`: A simple edgeapp that demonstrates how to create an edgeapp that runs "Hello World" when accessed.
- `<app-slug>`: The slug of the app. This will be used as the directory name for the new app. It should be a unique identifier for the app and only use the characters `a-z`, `0-9`, and `-`.
- `<app_name>`: The name of the app. This will be used as the display name for the app. Example: `Syncthing`
- `<app-description>`: A short description of the app. This will be used as the description for the app. Example: `Sync Filesystem`
- `<has-options>`: A `yes` or `no` value indicating if the app has options. This will be used to determine if the app should have a configuration page in the dashboard. Default: `no`. If `yes`, it will include the necessary example configuration file in the new app.

For example, to create a new app called `syncthing` from the `hello` template, you would run:
```bash
./.templates/bootstrap.sh hello syncthing Syncthing "Sync Filesystem" no
```

This will create a new app in the `./apps/` directory with the slug `syncthing` and the name `Syncthing` that uses the `hello` template as a base. You can then customize the app as needed (change the Dockerfile, add more services, environment variables, build and install assets, etc).
