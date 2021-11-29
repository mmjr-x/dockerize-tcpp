#!/bin/bash

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

# Process mounted configs
# https://stackoverflow.com/a/7810345/13620003
[ -f "/tcpp-configs/worldserver-changes.conf" ] && crudini --merge /tcpp-server/etc/worldserver.conf < /tcpp-configs/worldserver-changes.conf

# # Uncomment this if you want to just run the container indefinitely (to inspect it or something)
# tail -f /dev/null

# Wait for database to be up
# while ! curl -o - tcpp-db:3306; do sleep 1; done
# while ! wget tcpp-db:3306; do sleep 1; done
while ! mysqladmin ping -h"tcpp-db" --silent; do sleep 1; done

# Start the worldserver
cd /tcpp-server/bin
# ./worldserver
# We should probably use exec here since it should allow to pass through SIGTERM for gracefull shutdown
# https://betterprogramming.pub/shut-down-docker-apps-gracefully-even-when-running-in-tmux-or-screen-41e68ff17187
# exec ./worldserver
# TODO: This does not play nicely with stopping via SIGTERM, see if we can fix that
(printf "yes\nyes\nyes\nyes\n" && cat) | exec ./worldserver