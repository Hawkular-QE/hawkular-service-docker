FROM jboss/base-jdk:8

ENV JBOSS_BASE=/opt/jboss

WORKDIR ${JBOSS_BASE}

ADD build-env runtime-env \
    output/hawkular-services-dist.zip \
    hawkular-install.sh \
    check-cnode.sh \
    hawkular-start.sh ${JBOSS_BASE}/

USER root
RUN ${JBOSS_BASE}/hawkular-install.sh 
USER jboss

VOLUME /var/hawkular-data

EXPOSE 8080

CMD ["/bin/bash", "-c", "${JBOSS_BASE}/hawkular-start.sh"]
