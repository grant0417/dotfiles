#!/bin/sh

newsboat -x reload

UNREAD=$(newsboat -x print-unread | awk '{print $1;}')

if [ "$UNREAD" -gt 0 ]; then
  echo "$UNREAD"
else
  echo ""
fi
