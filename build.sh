#!/bin/bash
source ./build-env
echo "## build-env ##"
cat build-env
echo "##"
rm -rf output/* 

if [ "$USE_REMOTE_REPO" = "yes" ]; then
  echo "Use remote repo"
  mvn org.apache.maven.plugins:maven-dependency-plugin:2.10:get\
  -DremoteRepositories=${REPO_URL}\
  -Dartifact=${ARTIFACT}\
  -Dtransitive=false 
fi

mvn org.apache.maven.plugins:maven-dependency-plugin:2.10:copy\
  -Dartifact="${ARTIFACT}"\
  -DoutputDirectory=output\
  -Dmdep.stripVersion=true\
  -Dmdep.stripClassifier=true &&\
  echo "## Docker build" &&\
  docker build --force-rm=true --no-cache=true --rm=true --tag=${DOCKER_TAG} .
 
exit $?
