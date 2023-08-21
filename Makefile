create_cluster:
	eksctl create cluster -f cluster.yaml

create_iamserviceaccount:
	eksctl create iamserviceaccount \
    --name ebs-csi-controller-sa \
    --namespace kube-system \
    --cluster my-cluster \
    --role-name AmazonEKS_EBS_CSI_DriverRole \
    --role-only \
    --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
	--approve

oidc_approve:
	eksctl utils associate-iam-oidc-provider --region=ap-northeast-1 --cluster=myEks --approve

create_iamserviceaccount:

create_addon:
	eksctl create addon --name aws-ebs-csi-driver --cluster my-cluster --service-account-role-arn arn:aws:iam::111122223333:role/AmazonEKS_EBS_CSI_DriverRole --force

create_ns_p:
	kubectl create namespace prometheus

helm_add_prometheus:
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts 

helm_upgrade_prometheus:
	helm upgrade -i prometheus prometheus-community/prometheus \
    --namespace prometheus \
    --set alertmanager.persistentVolume.storageClass="gp2",server.persistentVolume.storageClass="gp2"

kubectl_pods:
	kubectl get pods -n prometheus

kubectl_deploy:
	kubectl --namespace=prometheus port-forward deploy/prometheus-server 9090

# Create grafana.yaml with the contents

create_ns_g:
	kubectl create namespace grafana

helm_install_grafana:
	helm install grafana grafana/grafana \
    --namespace grafana \
    --set persistence.storageClassName="gp2" \
    --set persistence.enabled=true \
    --set adminPassword='EKS!sAWSome' \
    --values grafana.yaml \
    --set service.type=LoadBalancer

get_all:
	kubectl get all -n grafana


add_grafana:
	helm repo add grafana https://grafana.github.io/helm-charts

helm_update:
	helm repo update

# Loki Installation

helm_install_loki:
	helm install loki-stack grafana/loki-stack

uninstall_prometheus:
	helm uninstall prometheus --namespace prometheus

uninstall_grafana:
	helm uninstall grafana --namespace grafana
