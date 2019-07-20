#!/bin/sh
set -e

if [ "$1" = 'bash' ]; then
  exec "$@"
  exit 0
fi

exec "$@"
