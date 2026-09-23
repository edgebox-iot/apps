# Hello World Edgeapp Template

This is a simple edgeapp template that demonstrates how to create an edgeapp that runs a "Hello World" when accessed.
It makes use of environment files, configurations and directories to demonstrate the customization capabilities for building and expanding self-hosted apps.

## Directory Structure

### Editable Files

These files make the structure of an edgeapp and can be edited to customize the edgeapp installation, runtime, and configuration.

- /src -> Source directory
- /src/build/ -> Files to be added to the container images build
- /src/install/ -> Files to be used with edgebox-postinstall.sh (ran after install)
- edgebox.env -> Environment file for the edgeapp, used to set container environment variables and meta data
- edgeapp.template.env -> Template environment file for the edgeapp, used to set Dashboard GUI configuration options
- edgebox-postinstall.sh -> Script ran after the edgeapp is fresh installed
- edgebox-hosts.txt -> Subdomain host names to be published by the edgeapp
- edgebox-compose.yml -> Defines the edgeapp services, containers, build, configuration, volumes, etc.
- Dockerfile - The Docker image used to build the edgeapp container image
- /README.md -> This file

### Dynamically Managed Files

These files do not exist initially, but can be created dynamically and are managed by the edgeapp and should not be edited manually.

- /appdata -> Holds running app data, directory used to hold container volumes
- .run -> Placeholder file to indicate this app should run upon edgebox containers status check
- edgeapp.env -> Environment file for the edgeapp, used to set container environment variables
- myedgeapp.env -> Environment file for the externally accessible domain, used to set container internet connectivity and domain configuration
- edgebox-postinstall.done -> Placeholder file to indicate the edgeapp post-install has ben ran previously