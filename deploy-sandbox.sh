#!/usr/bin/env bash
version=$(mvn -q \
    -Dexec.executable=echo \
    -Dexec.args='${project.version}' \
    --non-recursive \
    exec:exec)
echo $version
export KUBECONFIG=$HOME/.kube/viafirma-test-config && kubectl config --kubeconfig=$HOME/.kube/viafirma-test-config set-context viavansi
rm -rf tmpDeploy
mkdir tmpDeploy
cp deploy/kubernetes/sandbox/* tmpDeploy
cd tmpDeploy
sed -i -- 's/\$VERSION/'${version}-sandbox'/g' *
kubectl delete -f .
kubectl apply -f .
cd ..