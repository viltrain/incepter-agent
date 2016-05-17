#!/bin/sh
set -e

if [ ! -f ca.pem ]; then
	gen-certs.sh
fi

if [ "$#" -eq 0 -o "${1:0:1}" = '-' ]; then
	set -- docker daemon \
		--host=unix:///var/run/docker.sock \
		--host=tcp://0.0.0.0:2376 \
		--storage-driver=vfs \
		--tlsverify --tlscacert=/ca.pem --tlscert=/server-cert.pem --tlskey=/server-key.pem \
		"$@"
fi

#if [ "$1" = 'docker' -a "$2" = 'daemon' ]; then
#	# if we're running Docker, let's pipe through dind
#	# (and we'll run dind explicitly with "sh" since its shebang is /bin/bash)
#	set -- sh "$(which dind)" "$@"
#fi

exec "$@"