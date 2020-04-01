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
elm install stable/nginx-ingress \
    --namespace ingress-basic \
    -f internal-ingress.yaml \
    --set controller.replicaCount=2 \
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux
##
kubectl create namespace ingress-basic
##
kubectl apply -f ingress.yaml
##
kubectl get all -n ingress-nginx
##
kubectl apply -f juiceshop-aks.yaml
##
kubectl get service juiceshop-public