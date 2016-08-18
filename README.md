[![Build Status](http://jenkins.cloud1.hawkular.org/job/Build-Hawkular-Services-Docker-from-Maven/badge/icon)](http://jenkins.cloud1.hawkular.org/job/Build-Hawkular-Services-Docker-from-Maven)

# Description
Docker test image of [Hawkular-Services](https://github.com/hawkular/hawkular-services)

# How to Run
## Plain Docker
Cassandra storage (required)
```
docker run -d --name myCassandra -e CASSANDRA_START_RPC=true cassandra:3.7
```
Hawkular-Services
```
docker run -d \
  -e TEST_MODE=true \
  -e DB_TIMEOUT=180 \
  -e CASSANDRA_NODES=myCassandra \
  -p 8080:8080 -p 8443:8443 \
  --link myCassandra:myCassandra \
  hawkularqe/hawkular-services-docker
```

### Enviroment variables

- `TEST_MODE=true|false`: enable `jdoe` test account
- `DB_TIMEOUT=<n>`: if present Hawkular container will wait for Cassandra by polling port 9016 until timeout (in seconds) is lapsed

## OpenShift v3
- Create an instant app in your namespace

```
oc new-app --file=openshift/all-in-one-template.yaml
```

- Optionally you can upload the template to `openshift` namespace to make it available globally and use the UI to create new app
```
oc create -f openshift/all-in-one-template.yaml -n openshift
```
---

# More on the build 
- The build script downloads Hawkular-Services release .zip from [maven repo](http://central.maven.org/maven2/org/hawkular/services/hawkular-services-dist/)
- Add the zip file and configure hawkular-services in Dockerfile
