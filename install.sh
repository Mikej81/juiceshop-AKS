## Install Juiceshop using AKS (Cloud CLI)
##
## Set Resource Group Name & Cluster Name
myResourceGroup=MyResourceGroup
myclusterName=juiceCluster
az group create --name $myResourceGroup --location eastus
##
az aks create --resource-group $myResourceGroup --name $myclusterName --node-count 1 --enable-addons monitoring --generate-ssh-keys
##
##az aks install-cli
az aks get-credentials --resource-group $myResourceGroup --name $myclusterName
## create the namespace
kubectl create namespace juiceshop
## install nginx ingress controller
helm install nginx-ingress stable/nginx-ingress \
    --namespace juiceshop \
    --set controller.replicaCount=2 \
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux \
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux
##
kubectl apply -f juiceshop-aks.yaml
#kubectl apply -f juicer-ingress.yaml
##
kubectl get all -n juiceshop