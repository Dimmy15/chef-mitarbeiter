#!/bin/bash
set -o errexit -o pipefail
function -h {
cat <<\USAGE
 USAGE: haproxy_cfg <marathon host:port>

haproxy_cfg generates a config file to run HAProxy on localhost and proxy to a number of backend hosts.
If no Parameter is given Env Variable "$MARATHON_HOST" will be used.

To gracefully reload haproxy:

:; haproxy -f /path/to/config -p /var/run/haproxy.pid -sf $(cat /var/run/haproxy.pid)

USAGE
}; function --help { -h ;}



function header {
  cat <<EOF
global
  log 127.0.0.1 local0
  log 127.0.0.1 local1 notice
  maxconn 4096
  user haproxy
  group haproxy

defaults
  log         global
  retries     3
  maxconn     2000
  timeout  connect 5000
  timeout  client  50000
  timeout  server  50000

  stats enable
  stats auth admin:admin
  stats uri /haproxy

EOF
}

function marathon_apps {
  z="`curl -H "Accept: text/plain" -s "$1/v2/tasks"`"

  frontend "$z"
  backend "$z"
}

function frontend {
  cat <<EOF
frontend http-in
  bind *:80
  mode http
  option httplog
  option dontlognull
  option forwardfor
  option http-server-close
EOF

  while IFS= read 
  do
    set -- $REPLY
    local name="$1"
    cat <<EOF
  acl host_${name} hdr_beg(host) -i ${name}
  use_backend ${name}_cluster if host_${name}

EOF
  done <<< "$1"
}

function backend {
  while IFS= read 
  do
    set -- $REPLY
    local name="$1"
    local port="$2"
    shift 2
    cat <<EOF

backend ${name}_cluster
  option httpclose
  option forwardfor
  mode http
  balance leastconn
EOF
    while [[ $# -gt 0 ]]
    do
      out "  server ${name}-$# $1 check"
      shift
    done
  done <<< "$1"
}

function config {
  header
  marathon_apps "$@"
}

function main {
  config "$@"
}

function msg { out "$*" >&2 ;}
function err { local x=$? ; msg "$*" ; return $(( $x == 0 ? 1 : $x )) ;}
function out { printf '%s\n' "$*" ;}

if [[ -z "$1" || -z "$MARATHON_HOST" ]]
then
	err "No Marathon host is given"
	exit 1
fi


main "$@"
