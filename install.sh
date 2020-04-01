## Install Juiceshop using AKS (Cloud CLI)
##
az group create --name myResourceGroup --location eastus
##
az aks create --resource-group myResourceGroup --name juiceCluster --node-count 1 --enable-addons monitoring --generate-ssh-keys
##
##az aks install-cli
az aks get-credentials --resource-group myResourceGroup --name juiceCluster
##
kubectl get nodes
##
kubectl apply -f juiceshop-aks.yaml
##
kubectl get service juiceshop-public --watch