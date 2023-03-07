#!/usr/bin/env bash
set -e

env=$1
op=$2

function import() {
	if [[ $env != "dev" ]] && [[ $env != "prod" ]]; then
		notify-send "only 'dev' or 'prod' supported."
		exit 1
	fi
	if [[ ! -f "$HOME/Downloads/$env.ovpn" ]]; then
		notify-send "$env.ovpn not found."
		exit 1
	fi
	mkdir -p /tmp/openvpn/
	mv ~/Downloads/$env.ovpn /tmp/openvpn/$env.ovpn
	notify-send "$env.ovpn successfully imported."
}

function toggle() {
	if systemctl --quiet is-active openvpn-$env.service; then
		systemctl stop openvpn-$env.service 
		notify-send "$env.ovpn stopped."
	else
		systemctl start openvpn-$env.service 
		notify-send "$env.ovpn started."
	fi
}

function status() {
	if systemctl --quiet is-active openvpn-$env.service; then
		echo '{"text": "", "class": "active"}'
	else
		echo '{"text": "", "class": "inactive"}'
	fi
}

if [[ $op == "import" ]]; then
	import
elif [[ $op == "toggle" ]]; then
	toggle
else
	status
fi
