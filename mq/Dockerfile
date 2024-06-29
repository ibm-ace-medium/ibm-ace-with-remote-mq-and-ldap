FROM my-docker-repository/mq-install:9.3.5.0

ARG MQ_CLIENT_USERNAME=mqclient
ARG MQ_CLIENT_PASSWORD=passw0rd
ARG MQ_CLIENT_GROUP=mqclients

COPY --chmod=774 --chown=mqm:mqm mq-setup.sh /home/mqm/mq-setup.sh
COPY --chmod=774 --chown=mqm:mqm mq-start.sh /home/mqm/mq-start.sh
COPY --chmod=774 --chown=mqm:mqm mq-setup.mqsc /home/mqm/mq-setup.mqsc
COPY --chmod=774 --chown=mqm:mqm mq-setup-with-ldap.mqsc /home/mqm/mq-setup-with-ldap.mqsc
COPY --chmod=774 --chown=mqm:mqm mq-setup-with-ldap.sh /home/mqm/mq-setup-with-ldap.sh
COPY --chmod=544 icc-shift.sh /etc/profile.d/icc-shift.sh
COPY --chmod=500 init.sh /var/scripts/init.sh

RUN groupadd --gid 2100 ${MQ_CLIENT_GROUP}
RUN useradd --uid 1400 --gid ${MQ_CLIENT_GROUP} -s /bin/bash --create-home --home-dir /home/${MQ_CLIENT_USERNAME} ${MQ_CLIENT_USERNAME}
RUN usermod --password $(echo ${MQ_CLIENT_PASSWORD} | openssl passwd -1 -stdin) ${MQ_CLIENT_USERNAME}

RUN ["/home/mqm/mq-setup.sh", "QMgr01", "1414", "mqadmins", "mqclients", "IN"]
ENTRYPOINT ["/home/mqm/mq-start.sh", "QMgr01"]