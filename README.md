# About
Docker test build for [Hawkular-Services](https://github.com/hawkular/hawkular-services)

## How to Run
Start Cassandra storage (required)
```
docker run -d --name myCassandra -e CASSANDRA_START_RPC=true cassandra:3.7
```
Start Hawkular-Services
```
docker run -d \
  -e TEST_MODE=true
  -e CASSANDRA_NODES=myCassandra \
  -p 8080:8080 -p 8443:8443 \
  --link myCassandra:myCassandra 
  hawkularqe/hawkular-services-docker
```
`TEST_MODE=true` enables `jdoe` test account

## More on the build 
- The build script downloads Hawkular-Services release .zip from [maven repo](http://central.maven.org/maven2/org/hawkular/services/hawkular-services-dist/)
- Add the zip file and configure hawkular-services in Dockerfile
