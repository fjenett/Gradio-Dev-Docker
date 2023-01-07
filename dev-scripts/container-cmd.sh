#! /bin/bash

# See:
# https://docs.docker.com/config/containers/multi-service_container/

# Need to build the frontend once before starting dev servers
export NODE_OPTIONS=--max-old-space-size=32768 && ./scripts/build_frontend.sh

# Start backend dev server
./dev-scripts/start-backend-server.sh &

# Start frontend dev server
./dev-scripts/start-frontend-server.sh &

wait -n

exit $?