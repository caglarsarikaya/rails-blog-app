#!/bin/bash
set -e

# Create and set permissions for Rails directories
mkdir -p /rails/tmp/pids
mkdir -p /rails/log
touch /rails/log/development.log

# Set permissions
chmod -R 777 /rails/tmp
chmod -R 777 /rails/log

# Remove a potentially pre-existing server.pid for Rails
rm -f /rails/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile)
exec "$@"
