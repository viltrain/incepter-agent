FROM docker:1.11-dind

COPY dockerd-entrypoint.sh /usr/local/bin/
COPY gen-certs.sh /usr/local/bin/
COPY sign /usr/local/bin/

VOLUME /var/lib/docker
EXPOSE 2376

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []