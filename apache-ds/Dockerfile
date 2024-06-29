#FROM registry.access.redhat.com/ubi8/ubi
FROM my-docker-repository/rhel-base
LABEL maintainer="islavka2@gmail.com"

ARG APACHE_DS_PACKAGE=apacheds-2.0.0.AM26-x86_64.rpm
ARG APACHE_DS_URL=https://archive.apache.org/dist/directory/apacheds/dist/2.0.0.AM26/${APACHE_DS_PACKAGE}

RUN microdnf update -y &&  \
    microdnf install java-11-openjdk.x86_64 &&  \
    microdnf clean all

RUN mkdir -p /tmp/apache \
      && cd /tmp/apache \
      && curl -LO $APACHE_DS_URL \
      && chmod +x $APACHE_DS_PACKAGE  \
      && rpm -ivh $APACHE_DS_PACKAGE

#ENTRYPOINT ["bash", "-c", "sleep 600"]
CMD /etc/init.d/apacheds-2.0.0.AM26-default start && tail -F /var/lib/apacheds-2.0.0.AM26/default/log/wrapper.log


