#!/bin/sh

if [ ! -f /opt/syncserver/syncserver.ini ]; then
    cp -Rn /opt/syncserver/unmount_syncserver.ini/. /opt/syncserver/syncserver.ini
fi

$1
