#!/bin/sh

pkill nordvpnd 
rm -f /run/nordvpnd.sock

nordvpnd &

while [ ! -S /run/nordvpnd.sock ]; do
  sleep 0.25
done

nordvpn set dns 127.0.0.11
nordvpn set technology "${TECHNOLOGY:-openvpn}"

nordvpn whitelist add subnet $(ip -o -4 addr show eth0 | tr -s ' ' | cut -d ' ' -f4)

nordvpn login -u "$USERNAME" -p "$PASSWORD"

nordvpn connect

nordvpn status

exec tail -f --pid=$(pidof nordvpnd) /var/log/nordvpn/daemon.log
