## Beaver Deployment Helm Chart

This repository includes first step of Beaver Deployment Helm Chart. 
It includes a working Docker build and a deployment for kubernetes.


### Install

```
kubectl create namespace tools
kubectl -n tools apply -f helm-service-account.yaml
helm init --service-account tiller --tiller-namespace tools --upgrade
kubectl create clusterrolebinding default-rule --clusterrole=cluster-admin --serviceaccount=tools:tiller
kubectl patch deploy --namespace tools tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
```

### Add Helm Repo for wildbeavers

```
helm repo add beavergithub https://wildbeavers.github.io/beaver-deployment-application/
```

https://wildbeavers.github.io/beaver-deployment-application/

### Usage

To use the charts, the Helm tool must be installed and initialized. The best
place to start is by reviewing the [Helm Quick Start Guide](https://github.com/kubernetes/helm/blob/master/docs/quickstart.md).

### Contributing to the Chart

We welcome contributions and improvements. 

