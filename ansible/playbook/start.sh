#!/bin/bash -x 
LOCAL_IP=$(ip addr | awk '/inet/ && /eth0/{sub(/\/.*$/,"",$2); print $2}')
cat << EOF | sudo tee -a /etc/hosts
${LOCAL_IP} $(hostname)
EOF
sudo apt-get update -y
sudo apt-get install -y \
        git \
        make
KUBE_VERSION=v1.6.0
HELM_VERSION=v2.3.0
TMP_DIR=$(mktemp -d)
curl -sSL https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -o ${TMP_DIR}/kubectl
chmod +x ${TMP_DIR}/kubectl
sudo mv ${TMP_DIR}/kubectl /usr/local/bin/kubectl
curl -sSL https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar -zxv --strip-components=1 -C ${TMP_DIR}
sudo mv ${TMP_DIR}/helm /usr/local/bin/helm
rm -rf ${TMP_DIR}
# Clone the project:
git clone https://github.com/openstack/openstack-helm
cd openstack-helm-1
# Start a local Helm Server:
helm init --client-only
helm serve &
sleep 10
helm repo add local http://localhost:8879/charts
helm repo remove stable
# Package the Openstack-Helm Charts, and push them to your local Helm repository:
#make
# Build the Kubeadm-AIO Container
export KUBEADM_IMAGE=openstack-helm/kubeadm-aio:v1.6
sudo docker build --pull -t ${KUBEADM_IMAGE} tools/kubeadm-aio
export KUBE_VERSION=v1.6.2
./tools/kubeadm-aio/kubeadm-aio-launcher.sh
export KUBECONFIG=${HOME}/.kubeadm-aio/admin.conf
mkdir -p  ${HOME}/.kube
cat ${HOME}/.kubeadm-aio/admin.conf > ${HOME}/.kube/config
