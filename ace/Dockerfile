FROM my-docker-repository/ace-install:12.0.12.2 as builder

ADD ../MyPolicyProject /home/aceuser/MyPolicyProject
ADD ../RemoteMQTestApplication /home/aceuser/RemoteMQTestApplication

ENV LICENSE=accept
RUN . /opt/ibm/ace-12/server/bin/mqsiprofile \
    && set -x  \
    && ibmint package --input-path /home/aceuser/MyPolicyProject --output-bar-file /home/aceuser/MyPolicyProject.bar \
    && ibmint package --input-path /home/aceuser/RemoteMQTestApplication --output-bar-file /home/aceuser/RemoteMQTestApplication.bar

FROM ivansla/ace-install:12.0.12.2

ARG MQ_CLIENT_USERNAME=mqclient
ARG MQ_CLIENT_PASSWORD=passw0rd

COPY --chmod=777 --chown=aceuser:mqbrkrs ./ace/server.conf.yaml /home/aceuser/ace-server/
COPY --from=builder /home/aceuser/MyPolicyProject.bar /tmp/MyPolicyProject.bar
COPY --from=builder /home/aceuser/RemoteMQTestApplication.bar /tmp/RemoteMQTestApplication.bar

ENV LICENSE=accept
RUN . /opt/ibm/ace-12/server/bin/mqsiprofile \
    && set -x  \
    && mqsicreateworkdir /home/aceuser/ace-server \
    && ibmint deploy --input-bar-file /tmp/MyPolicyProject.bar --output-work-directory /home/aceuser/ace-server/ 2>&1 | tee -a /tmp/deploys \
    && ibmint deploy --input-bar-file /tmp/RemoteMQTestApplication.bar --output-work-directory /home/aceuser/ace-server/ 2>&1 | tee -a /tmp/deploys \


#    && for FILE in /tmp/*.bar; do \
#       echo "$FILE" >> /tmp/deploys && \
#       ibmint deploy --input-bar-file ${FILE} --output-work-directory /home/aceuser/ace-server/ 2>&1 | tee -a /tmp/deploys; done \
    && mqsisetdbparms -w /home/aceuser/ace-server -n mq::myMQ -u ${MQ_CLIENT_USERNAME} -p ${MQ_CLIENT_PASSWORD} \
    && chmod -R ugo+rwx /home/aceuser/ \
    && chmod -R ugo+rwx /var/mqsi/

# Expose ports.  7600, 7800, 7843 for ACE;
USER aceuser:mqbrkrs
EXPOSE 7600 7800 7843
# Set entrypoint to run the server
ENTRYPOINT ["bash", "-c", ". /opt/ibm/ace-12/server/bin/mqsiprofile && IntegrationServer -w /home/aceuser/ace-server"]


