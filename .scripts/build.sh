. ./.scripts/utils.sh

# Make sure directory where this runs is the directory where the apps and compose.yml are located
cd "$(dirname "$0")"
cd ../

ACTIVE_APPS=""
DOCKER_COMPOSE_ARGS=""

check_and_load_env_file

# Check if theres apps as arguments set, if so override the ACTIVE_APPS variable
if [ -n "$1" ]; then
    ACTIVE_APPS=""
    while [ "$1" != "" ]; do
        ACTIVE_APPS="$1 $ACTIVE_APPS"
        shift
done
fi

echo "🏗️  Preparing to build edgeapps: $ACTIVE_APPS"

# For each active app, add a `-f <app>/edgebox-compose.yml` argument to the `docker-compose` command
for app in $ACTIVE_APPS; do
    DOCKER_COMPOSE_ARGS="$DOCKER_COMPOSE_ARGS -f $app/edgebox-compose.yml"
done

DOCKER_COMPOSE_ARGS="$DOCKER_COMPOSE_ARGS -f compose.yml"

echo "🐳  Building operations:"
echo ""
docker-compose $DOCKER_COMPOSE_ARGS build

echo "\n🟢  Operations completed."
