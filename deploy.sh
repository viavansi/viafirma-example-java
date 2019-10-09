version=$(mvn -q \
    -Dexec.executable=echo \
    -Dexec.args='${project.version}' \
    --non-recursive \
    exec:exec)
echo $version
app="platform-example"
environment=$1
server="192.168.5.103"
user="viavansi"
password="viavansi"
sshpass -p "${password}" ssh ${user}@${server} "mkdir -p $app-$environment"
sshpass -p "${password}" scp deploy/kubernetes/$environment/$app-deployment.yaml ${user}@${server}:$app-$environment/$app-deployment.yaml
sshpass -p "${password}" scp deploy/kubernetes/$environment/$app-ingress.yaml ${user}@${server}:$app-$environment/$app-ingress.yaml
sshpass -p "${password}" ssh ${user}@${server} "cd $app-$1 && sed -i -- 's/\$VERSION/$version-$environment/g' $app-ingress.yaml && kubectl delete --ignore-not-found -f $app-ingress.yaml && kubectl apply -f $app-ingress.yaml"
sshpass -p "${password}" ssh ${user}@${server} "cd $app-$1 && sed -i -- 's/\$VERSION/$version-$environment/g' $app-deployment.yaml && kubectl delete --ignore-not-found -f $app-deployment.yaml && kubectl apply -f $app-deployment.yaml"