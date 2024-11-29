. ./.scripts/utils.sh

# Make sure directory where this runs is the directory where the apps and compose.yml are located
cd "$(dirname "$0")"
cd ../

ACTIVE_APPS=""
DOCKER_COMPOSE_ARGS=""
SERVICES_TO_STOP=""

# SERVICES_TO_STOP is a string of services to stop, e.g. "service1 service2", read from the arguments passed to this script
while [ "$1" != "" ]; do
    SERVICES_TO_STOP="$1 $SERVICES_TO_STOP"
    shift
done

check_and_load_env_file

# If no services are passed, print active apps instead
if [ -z "$SERVICES_TO_STOP" ]; then
    echo "✋ Stopping local edgeapps: $ACTIVE_APPS"
else
    echo "✋ Stopping local edgeapp services: $SERVICES_TO_STOP"
fi
# For each active app, add a `-f <app>/edgebox-compose.yml` argument to the `docker-compose` command
DOCKER_COMPOSE_ARGS="$DOCKER_COMPOSE_ARGS -f compose.yml"

for app in $ACTIVE_APPS; do
    DOCKER_COMPOSE_ARGS="$DOCKER_COMPOSE_ARGS -f $app/edgebox-compose.yml"
done

echo ""

# Docker-compose should stop $active_app-* containers for each active app
docker-compose $DOCKER_COMPOSE_ARGS down $SERVICES_TO_STOP

echo "\n🟢 Operations completed."