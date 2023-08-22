create_cluster:
	eksctl create cluster -f cluster.yaml

create_iamserviceaccount:
	eksctl create iamserviceaccount \
    --name ebs-csi-controller-sa \
    --namespace kube-system \
    --cluster <cluster-name> \
    --role-name AmazonEKS_EBS_CSI_DriverRole \
    --role-only \
    --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
	--approve

oidc_approve:
	eksctl utils associate-iam-oidc-provider --region=<region-name> --cluster=<cluster-name> --approve

create_iamserviceaccount:

create_addon:
	eksctl create addon --name aws-ebs-csi-driver --cluster <cluster-name> --service-account-role-arn arn:aws:iam::<account-id>:role/AmazonEKS_EBS_CSI_DriverRole --force

create_ns_p:
	kubectl create namespace prometheus

helm_add_prometheus:
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts 

helm_update:
	helm repo update

helm_upgrade_prometheus:
	helm upgrade -i prometheus prometheus-community/prometheus \
    --namespace prometheus \
    --set alertmanager.persistentVolume.storageClass="gp2",server.persistentVolume.storageClass="gp2" \
    --set service.type=LoadBalancer 

kubectl_pods:
	kubectl get pods -n prometheus

get_svc:
	kubectl get svc

kubectl_deploy:
	kubectl --namespace=prometheus port-forward deploy/prometheus-server 9090

# Create grafana.yaml with the contents
create_grafana:
	nano grafana.yaml

# create_ns_g:
# 	kubectl create namespace grafana

add_grafana:
	helm repo add grafana https://grafana.github.io/helm-charts

helm_update:

helm_install_grafana:
	helm install grafana grafana/grafana \
    --set persistence.storageClassName="gp2" \
    --set persistence.enabled=true \
    --set adminPassword='EKS!pass' \
    --values grafana.yaml \
    --set service.type=LoadBalancer 
# 	--namespace grafana 

get_all:
	kubectl get all -n grafana

get_pods:
	kubectl get pods -A

get_graf:
	kubectl get svc grafana

get_pass:
	kubectl get secret --namespace <name> grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

# Loki Installation

add_grafana:

helm_update:

helm_install_loki:
	helm install loki grafana/loki-stack

# Uninstallation

uninstall_prometheus:
	helm uninstall prometheus --namespace prometheus

uninstall_grafana:
	helm uninstall grafana

uninstall_loki:
	helm uninstall loki

delete_cluster:
	eksctl delete cluster --name <cluster-name>

# Additional commands

edit_prom:
	kubectl edit svc -n prometheus-server

edit_graf:
	kubectl edit svc grafana

watch_pods:
	kubectl get pods -w