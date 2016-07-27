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
  -e TEST_MODE=true
  -e CASSANDRA_NODES=myCassandra \
  -p 8080:8080 -p 8443:8443 \
  --link myCassandra:myCassandra 
  hawkularqe/hawkular-services-docker
```
`TEST_MODE=true` enables `jdoe` test account

## OpenShift v3
- Create an instant app in your namespace

```
oc new-app --file=openshift/hawk-services-template.yaml
```

- Optionally you can upload the template to `openshift` namespace to make it available globally and use the UI to create new app
```
oc create -f openshift/hawk-services-template.yaml -n openshift
```
---

# More on the build 
- The build script downloads Hawkular-Services release .zip from [maven repo](http://central.maven.org/maven2/org/hawkular/services/hawkular-services-dist/)
- Add the zip file and configure hawkular-services in Dockerfile
