#!/bin/bash

function install(){
	echo " * configuring rmfakecloud-proxy to use tailscale"
	mkdir -p /etc/systemd/system/rmfakecloud-proxy.service.d
	cat > /etc/systemd/system/rmfakecloud-proxy.service.d/proxy.conf <<EOF
[Service]
Environment="HTTP_PROXY=http://127.0.0.1:1055/"
Environment="HTTPS_PROXY=http://127.0.0.1:1055/"
EOF

	echo " * patching hosts"
	if ! grep lhf_start /etc/hosts ; then
		cat >> /etc/hosts <<EOF
# lhf_start
100.72.172.31 rmfakecloud.tail9db2a.ts.net
# lhf_end
EOF
	fi

	systemctl daemon-reload
	systemctl restart rmfakecloud-proxy
}	

function remove(){
	rm /etc/systemd/system/rmfakecloud-proxy.service.d/proxy.conf 
	sed -i '/# lhf_start/,/# lhf_end/d' /etc/hosts
	systemctl daemon-reload
	systemctl restart rmfakecloud-proxy
}

case $1 in
	"remove" )
		remove
		;;
	"install" )
		install
		;;
	* )
		echo "Usage: install/remove"
		;;
esac
