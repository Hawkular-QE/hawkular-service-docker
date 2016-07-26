. build-env
echo "## build-env ##"
cat build-env
echo "##"
rm -rf output/* &&\
mvn org.apache.maven.plugins:maven-dependency-plugin:2.10:get\
  -DremoteRepositories=${REPO_URL}\
  -Dartifact=${ARTIFACT}\
  -Dtransitive=false &&\
mvn org.apache.maven.plugins:maven-dependency-plugin:2.10:copy\
  -Dartifact="${ARTIFACT}"\
  -DoutputDirectory=output\
  -Dmdep.stripVersion=true\
  -Dmdep.stripClassifier=true &&\
  echo "## Docker build" &&\
  docker build --force-rm=true --no-cache=true --rm=true --tag=${DOCKER_TAG} .
 
exit $?
