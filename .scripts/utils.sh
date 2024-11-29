check_and_load_env_file() {

    # Check if the .env file exists
    if [ ! -f .env ]; then
        echo "🟡 No .env file detected. Create it by copying the .env.example file, and use it to fill default variables."
    else
        DOCKER_COMPOSE_ARGS="$DOCKER_COMPOSE_ARGS --env-file .env"
        # Check if the .env file contains the necessary environment variables
        if ! grep -q "ACTIVE_APPS" .env; then
            echo "🟡 The .env file does not contain the ACTIVE_APPS environment variable."
        else
            ACTIVE_APPS=$(grep ACTIVE_APPS .env | cut -d '=' -f2)
            if [ -z "$ACTIVE_APPS" ]; then
                echo "🟡 The ACTIVE_APPS environment variable is empty."
                exit 1
            fi
        fi

        if ! grep -q "HOST_PORT" .env; then
            echo "🟡 The .env file does not contain the HOST_PORT environment variable. Defaulting to port 80."
        else
            HOST_PORT=$(grep HOST_PORT .env | cut -d '=' -f2)
            if [ -z "$HOST_PORT" ]; then
                echo "🟡 The HOST_PORT environment variable is empty."
                exit 1
            fi
        fi


    fi
}

get_lan_ip () {
    for adaptor in eth0 wlan0 enp0s1; do
        if ip -o -4 addr list $adaptor  > /dev/null 2>&1 ; then
            ip=$(ip -o -4 addr list $adaptor | awk '{print $4}' | cut -d/ -f1)
        fi
    done

    echo $ip
}

remove_hosts_entries() {
    sudo sed -i '' '/### Local Edgeapps/,/### End Local Edgeapps/d' /etc/hosts
}