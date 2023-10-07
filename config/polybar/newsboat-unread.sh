#!/bin/sh

set -e

newsboat -x reload

declare UNREAD
UNREAD=$(newsboat -x print-unread | awk '{print $1;}')

if [ "$UNREAD" -gt 0 ]; then
  echo "$UNREAD"
else
  echo ""
fi
