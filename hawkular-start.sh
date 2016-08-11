: ${JBOSS_BASE:=/opt/jboss}
. ${JBOSS_BASE}/runtime-env

if [ "${TEST_MODE}" == "true" ]; then
   echo " ## Test mode detected ##"
   "${HAWKULAR_HOME}/bin/add-user.sh" \
     -a \
     -u "${HAWKULAR_USERNAME}" \
     -p "${HAWKULAR_PASSWORD}" \
     -g read-write,read-only
fi

if [ !  -z "${CASSANDRA_NODES}" ]; then
   echo " ## Using external storage nodes ##"
   export HAWKULAR_BACKEND=remote
elif [ ! -z "${CASSANDRA_SERVICE}" ]; then
   echo " ## Using Kubernetes-style named service"
   eval "s=${CASSANDRA_SERVICE^^}_SERVICE_HOST"
   export CASSANDRA_NODES=${!s}
   HAWKULAR_BACKEND=remote
fi

echo "CASSANDRA_NODES='${CASSANDRA_NODES}'"

if [ ! -z ${DB_TIMEOUT} ]; then
  echo "Waiting for DB (timeout=${DB_TIMEOUT})"
  DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  timeout ${DB_TIMEOUT} ${DIR}/check-cnode.sh ${CASSANDRA_NODES}
  status=$?
  if [[ $status -eq 124 ]]; then
    echo "DB timed out"
    exit $?
  fi
  if [ ! $status ]; then
    exit 1
  fi
fi

${HAWKULAR_HOME}/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 \
  -Dhawkular.rest.user="${HAWKULAR_USERNAME}" \
  -Dhawkular.rest.password="${HAWKULAR_PASSWORD}" \
  -Dhawkular.agent.enabled="${AGENT_ENABLED}" \
  -Djboss.server.data.dir=/var/hawkular-data \

exit $?
