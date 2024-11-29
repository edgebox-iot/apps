. ./.scripts/utils.sh

# Make sure directory where this runs is the directory where the apps and compose.yml are located
cd "$(dirname "$0")"
cd ../

echo "🏁 Preparing to start local edgeapps"

ACTIVE_APPS=""
DOCKER_COMPOSE_ARGS=""

check_and_load_env_file

# Check if $1 is set, if so override the ACTIVE_APPS variable
if [ -n "$1" ]; then
    ACTIVE_APPS=$1
fi

# For each active app, add a `-f <app>/edgebox-compose.yml` argument to the `docker-compose` command
DOCKER_COMPOSE_ARGS="$DOCKER_COMPOSE_ARGS -f compose.yml"
PUBLISH_DOMAINS="true"
hosts_file_content=""

if command -v avahi-publish -h &> /dev/null; then
    echo "🟢 mDNS service publishing is enabled."
else
    echo "🟡 mDNS service publishing is disabled. Using /etc/hosts file fallback (Requires Admin). Install avahi-publish to solve."
    PUBLISH_DOMAINS="false"
    remove_hosts_entries
    hosts_file_content+="\n### Local Edgeapps"
fi

echo "🚀 Gathering information about target apps: $ACTIVE_APPS"

local_ip=$(get_lan_ip)
hostname=$(hostname)
domain=".local"
config_name="edgebox-hosts.txt"
port=""
domains_list=()

# Check if HOST_PORT is set, if so override the port variable
if [ -n "$HOST_PORT" ]; then
    port=":$HOST_PORT"
fi

for app in $ACTIVE_APPS; do
    DOCKER_COMPOSE_ARGS="$DOCKER_COMPOSE_ARGS -f $app/edgebox-compose.yml"
    HOSTS_FILE="$app/$config_name"
    SERVICE_NAME=$app
    domains_list+=("http://$app$domain$port")

    if [ "$PUBLISH_DOMAINS" = "true" ]; then
        if test -f "$HOSTS_FILE"; then
            # echo "Found configuration for $SERVICE_NAME service"
            while IFS= read -r line; do
                # echo "🌐  Setting up mDNS host $line$domain"
                nohup avahi-publish -a $line$domain -R $local_ip >/dev/null 2>&1 &
                sleep 1
            done < "$HOSTS_FILE"
        fi
    else
        # 2nd: Add the new entries
        while IFS= read -r line; do
            # echo "🌐 Setting up local host http://$line$domain"
            hosts_file_content+="\n127.0.0.1 $line$domain"
        done < "$HOSTS_FILE"
    fi
    
done

if [ "$PUBLISH_DOMAINS" = "false" ]; then
    hosts_file_content+="\n### End Local Edgeapps"
    # 3rd: Append the new entries to the hosts file
    echo "$hosts_file_content" | sudo tee -a /etc/hosts > /dev/null
fi

echo "🐳 Setting up Containers:\n"
# I want to put a - in front of the first line of output from docker-compose
docker-compose $DOCKER_COMPOSE_ARGS up -d --remove-orphans

# Unpack the domains list as \n - separated string
domains=$(printf " ✔ %s\n" "${domains_list[@]}")
echo "\n🌐  Setting up local domains: \n\n$domains"

echo "\n🟢 Operations completed. Use the host urls 👆 to access your apps."