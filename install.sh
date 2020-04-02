## Install Juiceshop using AKS (Cloud CLI)
##
az group create --name myResourceGroup --location eastus
##
az aks create --resource-group myResourceGroup --name juiceCluster --node-count 1 --enable-addons monitoring --generate-ssh-keys
##
##az aks install-cli
az aks get-credentials --resource-group myResourceGroup --name juiceCluster
## create the namespace
kubectl create namespace juiceshop
# Add the official stable repositories
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo add multi-juicer https://iteratec.github.io/multi-juicer/
## install nginx ingress controller
helm install nginx-ingress stable/nginx-ingress \
    --namespace juiceshop \
    -f internal-ingress.yaml \
    --set controller.replicaCount=2 \
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux
##
#kubectl get service -l app=nginx-ingress --namespace juiceshop
helm install multi-juicer multi-juicer/multi-juicer --namespace juiceshop \
    --set title="AKS Juiceshop Primary" \
    --set serviceName="juiceshop1"
helm install multi-juicer multi-juicer/multi-juicer --namespace juiceshop \
    --set title="AKS Juiceshop Secondary" \
    --set serviceName="juiceshop2"
##
kubectl get all -n juiceshop
##
#kubectl apply -f juiceshop-aks.yaml
kubectl apply -f juicer-ingress.yaml
##
#kubectl get service