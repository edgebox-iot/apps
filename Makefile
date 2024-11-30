# Define the variables for the commands
# to build the applicationn: app_slug, app_name, app_description, has_options template

ifndef template
override template = ""
endif

ifndef app_slug
override app_slug = hello
endif

ifndef app_name
override app_name = "Hello World"
endif

ifndef app_description
override app_description = "Test App"
endif

ifndef has_options
override has_options = no
endif

ifndef environment
override environment = local
endif

ifndef apps
override apps = ""
endif

ifndef services
override services = ""
endif

# Install necessary dependencies to run apps locally
install:
	@echo "Installing Dev Environment"
	./.scripts/install_${environment}.sh

# Bootstrap a new app based on a template
app:
	@./.scripts/bootstrap.sh "${template}" "${app_slug}" "${app_name}" "${app_description}" "${has_options}"

bootstrap: app

# Build an app locally:
build:
	@./.scripts/build.sh "${apps}""

# Clean an app locally:
clean:
	@echo "Cleaning ${apps}"
	@./.scripts/clean.sh "${apps}"

# Run an app locally:
run:
	@./.scripts/run.sh "${apps}"

start: run

# Stop an app locally:
stop:
	@./.scripts/stop.sh "${services}"

status:
	@./.scripts/status.sh