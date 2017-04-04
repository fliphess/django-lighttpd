#!/bin/bash
set -e

## Start uwsgi
/opt/django/bin/manage_uwsgi --start

## Start lighttpd
/opt/django/bin/manage_lighttpd --start

## Something to lure at while waiting
tail -f -n +1 /opt/django/log/*.log
