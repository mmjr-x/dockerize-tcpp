#!/bin/bash

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

# Process mounted configs
# https://stackoverflow.com/a/7810345/13620003
[ -f "/tcpp-configs/bnetserver-changes.conf" ] && crudini --merge /tcpp-server/etc/bnetserver.conf < /tcpp-configs/bnetserver-changes.conf

# # Uncomment this if you want to just run the container indefinitely (to inspect it or something)
# tail -f /dev/null

# Wait for database to be up
# while ! curl -o - tcpp-db:3306; do sleep 1; done
# while ! wget tcpp-db:3306; do sleep 1; done
# TODO: Sadly this does not work, since the required database acctually needs to be present
# while ! mysqladmin ping -h"tcpp-db" --silent; do sleep 1; done
# while ! (mysqladmin ping -h"tcpp-db" --silent && mysql -h'tcpp-db' -u'trinity' -p'trinity' -s -N -e "SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'auth'") ; do sleep 1; done
while ! (mysqladmin ping -h"tcpp-db" --silent && mysql -h'tcpp-db' -u'trinity' -p'trinity' -s -N -e "USE auth;") ; do sleep 1; done

# Start the worldserver
cd /tcpp-server/bin
# ./bnetserver
# We should probably use exec here since it should allow to pass through SIGTERM for gracefull shutdown
# https://betterprogramming.pub/shut-down-docker-apps-gracefully-even-when-running-in-tmux-or-screen-41e68ff17187
exec ./bnetserver