echo "Preparing env..."

echo "---------- Installing kubectl ----------"
curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.5/bin/linux/amd64/kubectl"
chmod u+x ./kubectl

echo "---------- Installing & configuring litmusctl ----------"
curl "https://litmusctl-production-bucket.s3.amazonaws.com/litmusctl-linux-amd64-0.15.0.tar.gz" -o litmusctl.tar.gz
tar -zxvf litmusctl.tar.gz
chmod +x ./litmusctl
./litmusctl config set-account --endpoint="http://192.168.58.4:31035" --username="jenkins" --password="jenkins"

echo "---------- Downloading test experiment ----------"
curl "https://raw.githubusercontent.com/AlvaroGG0/litmusChaos-jenkins-integration-dev/master/experiments/nginx-pod-delete-test.yaml" -o nginx-pod-delete-test.yaml

echo "---------- Downloading wait_chaos_finish script ----------"
curl -O "https://raw.githubusercontent.com/AlvaroGG0/litmusChaos-jenkins-integration-dev/master/scripts/wait_chaos_finish.sh"
