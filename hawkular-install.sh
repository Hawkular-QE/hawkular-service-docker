: ${JBOSS_BASE:=/opt/jboss}
. ${JBOSS_BASE}/build-env
. ${JBOSS_BASE}/runtime-env

yum install -y nmap-ncat && yum clean all &&\
 unzip -qq -d ${JBOSS_BASE} ${JBOSS_BASE}/hawkular-services-dist.zip &&\
rm -f ${JBOSS_BASE}/hawkular-services-dist.zip &&\
ln -s ${JBOSS_BASE}/hawkular-services-dist-${HAWKULAR_VERSION} ${HAWKULAR_HOME} &&\
mkdir -p /var/hawkular-data &&\
chmod +x ${HAWKULAR_HOME}/bin/*.sh &&\
chown -R jboss:0 ${JBOSS_BASE} /var/hawkular-data &&\
chmod -R g+rw ${JBOSS_BASE} /var/hawkular-data

exit $?
