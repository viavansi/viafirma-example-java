#!/usr/bin/env bash

docker login -u jenkins -p Jenkins12345 registry.viafirma.com
appVersion=$(mvn -q -Dexec.executable=echo -Dexec.args='${project.version}' --non-recursive exec:exec)

cp target/ejemploViafirma.war docker


if [ $# -eq 0 ]
  then
        dockerImageVersion=${appVersion}
  else
        dockerImageVersion=${appVersion}-$1
fi
tag_version="registry.viafirma.com/viafirma/platform/platform-example:${dockerImageVersion}"

cd docker
docker build -t ${tag_version} .
docker push ${tag_version}
cd ..