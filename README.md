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


## Edgeapp Structure

TBD

## Setting prod or dev app modes

TBD
 
