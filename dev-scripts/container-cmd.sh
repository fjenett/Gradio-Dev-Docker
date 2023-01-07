#! /bin/bash

# See:
# https://docs.docker.com/config/containers/multi-service_container/

./dev-scripts/start-frontend-server.sh &

./dev-scripts/start-backend-server.sh &

wait -n

exit $?