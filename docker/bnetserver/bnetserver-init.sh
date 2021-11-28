#!/bin/bash

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

# Process mounted configs
# https://stackoverflow.com/a/7810345/13620003
[ -f "/tcpp-configs/bnetserver-changes.conf" ] && crudini --merge /tcpp-server/etc/bnetserver.conf < /tcpp-configs/bnetserver-changes.conf

# # Uncomment this if you want to just run the container indefinitely (to inspect it or something)
# tail -f /dev/null

# Start the worldserver
cd /tcpp-server/bin
./bnetserver