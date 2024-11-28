# Define the variables for the commands
# to build the applicationn: app_slug, app_name, app_description, has_options template

ifndef template
override template = "hello"
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

ifndef target_app
override target_app = ""
endif

# Install necessary dependencies to run apps locally
install:
	@echo "Installing Dev Environment"
	./.scripts/install_${environment}.sh

# Bootstrap a new app based on a template
app:
	@./.scripts/bootstrap.sh ${template} ${app_slug} ${app_name} ${app_description} ${has_options}

# Build an app locally:
build:
	@echo "Building ${target_app}"
	@./.scripts/build.sh ${target_app}

# Clean an app locally:
clean:
	@echo "Cleaning ${target_app}"
	@./.scripts/clean.sh ${target_app}

# Run an app locally:
run:
	@echo "Running ${target_app}"
	@./.scripts/run.sh ${target_app}

# Stop an app locally:
stop:
	@echo "Stopping ${target_app}"
	@./.scripts/stop.sh ${target_app}

status:
	@echo "Status of ${target_app}"
	@./.scripts/status.sh ${target_app}