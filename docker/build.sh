#!/usr/bin/env bash

cd ..
docker login -u jenkins -p Jenkins12345 registry.viafirma.com
appVersion=$(mvn -q -Dexec.executable=echo -Dexec.args='${project.version}' --non-recursive exec:exec)
echo $appVersion
cp target/ejemploViafirma.war docker

tag_version="registry.viafirma.com/viafirma/platform/platform-example:${appVersion}"
latest_version="registry.viafirma.com/viafirma/platform/platform-example:latest"

cd docker
docker build -t ${tag_version} .
docker tag ${tag_version} ${latest_version}

docker push ${latest_version}
docker push ${tag_version}