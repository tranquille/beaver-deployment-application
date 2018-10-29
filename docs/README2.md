
# Wekan

Helm chart for [Wekan](https://wekan.io).

-  Use [official Docker image](https://quay.io/wekan/wekan).

## ToDo

-  Documentation
-  Liveness Probe
## Kong

[Kong](https://getkong.org/) is an open-source API Gateway and Microservices
Management Layer, delivering high performance and reliability.

## TL;DR;

```bash
helm install --namespace ingress-system --name kong beavergithub/kong --wait --debug --tiller-namespace tools
```

## Introduction

This chart bootstraps all the components needed to run Kong on a [Kubernetes](http://kubernetes.io)
cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.8+ with Beta APIs enabled.
- PV provisioner support in the underlying infrastructure if persistence
  is needed for Kong datastore.

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release beavers/kong
```

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the
chart and deletes the release.

## Configuration

### General Configuration Parameters

The following tables lists the configurable parameters of the Kong chart
and their default values.

| Parameter                         | Description                                                            | Default               |
| ------------------------------    | --------------------------------------------------------------------   | -------------------   |
| image.repository                  | Kong image                                                             | `kong`                |
| image.tag                         | Kong image version                                                     | `0.12.2`              |
| image.pullPolicy                  | Image pull policy                                                      | `IfNotPresent`        |
| replicaCount                      | Kong instance count                                                    | `1`                   |
| admin.useTLS                      | Secure Admin traffic                                                   | `true`                |
| admin.servicePort                 | TCP port on which the Kong admin service is exposed                    | `8444`                |
| admin.containerPort               | TCP port on which Kong app listens for admin traffic                   | `8444`                |
| admin.nodePort                    | Node port when service type is `NodePort`                              |                       |
| admin.type                        | k8s service type, Options: NodePort, ClusterIP, LoadBalancer           | `NodePort`            |
| admin.loadBalancerIP              | Will reuse an existing ingress static IP for the admin service         | `null`                |
| proxyhttp.servicePort            | TCP port on which the Kong Proxy Service is exposed                    | `8000`                |
| proxyhttp.containerPort          | TCP port on which the Kong app listens for Proxy traffic               | `8000`                |
| proxyhttp.nodePort               | Node port when service type is `NodePort`                              | `32080`               |
| proxyhttp.type                   | k8s service type. Options: NodePort, ClusterIP, LoadBalancer           | `NodePort`            |
| proxyhttp.loadBalancerIP         | To reuse an existing ingress static IP for the admin service           |                       |
| proxyhttps.servicePort           | TCP port on which the Kong Proxy Service is exposed                    | `8443`                |
| proxyhttps.containerPort         | TCP port on which the Kong app listens for Proxy traffic               | `8443`                |
| proxyhttps.nodePort              | Node port when service type is `NodePort`                              | `32443`               |
| proxyhttps.type                  | k8s service type. Options: NodePort, ClusterIP, LoadBalancer           | `NodePort`            |
| proxyhttps.loadBalancerIP        | To reuse an existing ingress static IP for the admin service           |                       |
| env                               | Additional [Kong configurations](https://getkong.org/docs/latest/configuration/)               |
| runMigrations                     | Run Kong migrations job                                                | `true`                |
| readinessProbe                    | Kong readiness probe                                                   |                       |
| livenessProbe                     | Kong liveness probe                                                    |                       |
| affinity                          | Node/pod affinities                                                    |                       |
| nodeSelector                      | Node labels for pod assignment                                         | `{}`                  |
| podAnnotations                    | Annotations to add to each pod                                         | `{}`                  |
| resources                         | Pod resource requests & limits                                         | `{}`                  |
| tolerations                       | List of node taints to tolerate                                        | `[]`                  |
| domain                            | for fresh installation of kong-ui we need to set the domain            | ``                    |

### Kong-specific parameters

Kong has a choice of either Postgres or Cassandra as a backend datatstore.
This chart allows you to choose either of them with the `env.database`
parameter.  Postgres is chosen by default.

Additionally, this chart allows you to use your own database or spin up a new
instance by using the `postgres.enabled` or `cassandra.enabled` parameters.
Enabling both will create both databases in your cluster, but only one
will be used by Kong based on the `env.database` parameter.
Postgres is enabled by default.

| Parameter                         | Description                                                            | Default               |
| ------------------------------    | --------------------------------------------------------------------   | -------------------   |
| cassandra.enabled                 | Spin up a new cassandra cluster for Kong                               | `false`               |
| postgresql.enabled                  | Spin up a new postgres instance for Kong                               | `true `               |
| env.database                      | Choose either `postgres` or `cassandra`                                | `postgres`            |
| env.pg_user                       | Postgres username                                                      | `kong`                |
| env.pg_database                   | Postgres database name                                                 | `kong`                |
| env.pg_password                   | Postgres database password (required if you are using your own database)| `kong`         |
| env.pg_host                       | Postgres database host (required if you are using your own database)   | ``                    |
| env.pg_port                       | Postgres database port                                                 | `5432`                |
| env.cassandra_contact_points      | Cassandra contact points (required if you are using your own database) | ``                    |
| env.cassandra_port                | Cassandra query port                                                   | `9042`                |
| env.cassandra_keyspace            | Cassandra keyspace                                                     | `kong`                |
| env.cassandra_repl_factor         | Replication factor for the Kong keyspace                               | `2`                   |

For complete list of Kong configurations please check https://getkong.org/docs/0.11.x/configuration/.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install beavers/kong --name my-release \
  --set=image.tag=0.11.2,env.database=cassandra,cassandra.enabled=true
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install beavers/kong --name my-release -f values.yaml
```

> **Tip**: You can use the default [values.yaml](values.yaml)
# Grafana Helm Chart

* Installs the web dashboarding system [Grafana](http://grafana.org/)

## TL;DR;

```console
$ helm install stable/grafana
```

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install --name my-release stable/grafana
```

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.


## Configuration


| Parameter                       | Description                                   | Default                                                 |
|---------------------------------|-----------------------------------------------|---------------------------------------------------------|
| `replicas`                      | Number of nodes                               | `1`                                                     |
| `deploymentStrategy`            | Deployment strategy                           | `RollingUpdate`                                         |
| `securityContext`               | Deployment securityContext                    | `{"runAsUser": 472, "fsGroup": 472}`                    |
| `image.repository`              | Image repository                              | `grafana/grafana`                                       |
| `image.tag`                     | Image tag. (`Must be >= 5.0.0`)               | `5.2.3`                                                 |
| `image.pullPolicy`              | Image pull policy                             | `IfNotPresent`                                          |
| `service.type`                  | Kubernetes service type                       | `ClusterIP`                                             |
| `service.port`                  | Kubernetes port where service is exposed      | `9000`                                                  |
| `service.annotations`           | Service annotations                           | `80`                                                    |
| `service.labels`                | Custom labels                                 | `{}`                                                    |
| `ingress.enabled`               | Enables Ingress                               | `false`                                                 |
| `ingress.annotations`           | Ingress annotations                           | `{}`                                                    |
| `ingress.labels`                | Custom labels                                 | `{}`                                                    |
| `ingress.hosts`                 | Ingress accepted hostnames                    | `[]`                                                    |
| `ingress.tls`                   | Ingress TLS configuration                     | `[]`                                                    |
| `resources`                     | CPU/Memory resource requests/limits           | `{}`                                                    |
| `nodeSelector`                  | Node labels for pod assignment                | `{}`                                                    |
| `tolerations`                   | Toleration labels for pod assignment          | `[]`                                                    |
| `affinity`                      | Affinity settings for pod assignment          | `{}`                                                    |
| `persistence.enabled`           | Use persistent volume to store data           | `false`                                                 |
| `persistence.size`              | Size of persistent volume claim               | `10Gi`                                                  |
| `persistence.existingClaim`     | Use an existing PVC to persist data           | `nil`                                                   |
| `persistence.storageClassName`  | Type of persistent volume claim               | `nil`                                                   |
| `persistence.accessModes`       | Persistence access modes                      | `[]`                                                    |
| `persistence.subPath`           | Mount a sub dir of the persistent volume      | `""`                                                    |
| `schedulerName`                 | Alternate scheduler name                      | `nil`                                                   |
| `env`                           | Extra environment variables passed to pods    | `{}`                                                    |
| `envFromSecret`                 | Name of a Kubenretes secret (must be manually created in the same namespace) containing values to be added to the environment | `""` |
| `extraSecretMounts`             | Additional grafana server secret mounts       | `[]`                                                    |
| `datasources`                   | Configure grafana datasources                 | `{}`                                                    |
| `dashboardProviders`            | Configure grafana dashboard providers         | `{}`                                                    |
| `dashboards`                    | Dashboards to import                          | `{}`                                                    |
| `dashboardsConfigMaps`          | ConfigMaps reference that contains dashboards | `{}`                                                    |
| `grafana.ini`                   | Grafana's primary configuration               | `{}`                                                    |
| `ldap.existingSecret`           | The name of an existing secret containing the `ldap.toml` file, this must have the key `ldap-toml`. | `""` |
| `ldap.config  `                 | Grafana's LDAP configuration                  | `""`                                                    |
| `annotations`                   | Deployment annotations                        | `{}`                                                    |
| `podAnnotations`                | Pod annotations                               | `{}`                                                    |
| `sidecar.dashboards.enabled`    | Enabled the cluster wide search for dashboards and adds/updates/deletes them in grafana | `false`       |
| `sidecar.dashboards.label`      | Label that config maps with dashboards should have to be added | `false`                                |
| `sidecar.datasources.enabled`   | Enabled the cluster wide search for datasources and adds/updates/deletes them in grafana |`false`       |
| `sidecar.datasources.label`     | Label that config maps with datasources should have to be added | `false`                               |
| `smtp.existingSecret`           | The name of an existing secret containing the SMTP credentials, this must have the keys `user` and `password`. | `""` |

## Sidecar for dashboards

If the parameter `sidecar.dashboards.enabled` is set, a sidecar container is deployed in the grafana pod. This container watches all config maps in the cluster and filters out the ones with a label as defined in `sidecar.dashboards.label`. The files defined in those configmaps are written to a folder and accessed by grafana. Changes to the configmaps are monitored and the imported dashboards are deleted/updated. A recommendation is to use one configmap per dashboard, as an reduction of multiple dashboards inside one configmap is currently not properly mirrored in grafana.
Example dashboard config:
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: sample-grafana-dashboard
  labels:
     grafana_dashboard: 1
data:
  k8s-dashboard.json: |-
  [...]
```

## Sidecar for datasources

If the parameter `sidecar.datasource.enabled` is set, a sidecar container is deployed in the grafana pod. This container watches all config maps in the cluster and filters out the ones with a label as defined in `sidecar.datasources.label`. The files defined in those configmaps are written to a folder and accessed by grafana on startup. Using these yaml files, the data sources in grafana can be modified.

Example datasource config adapted from [Grafana](http://docs.grafana.org/administration/provisioning/#example-datasource-config-file):
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: sample-grafana-datasource
  labels:
     grafana_datasource: 1
data:
	datasource.yaml: |-
		# config file version
		apiVersion: 1

		# list of datasources that should be deleted from the database
		deleteDatasources:
		  - name: Graphite
		    orgId: 1

		# list of datasources to insert/update depending
		# whats available in the database
		datasources:
		  # <string, required> name of the datasource. Required
		- name: Graphite
		  # <string, required> datasource type. Required
		  type: graphite
		  # <string, required> access mode. proxy or direct (Server or Browser in the UI). Required
		  access: proxy
		  # <int> org id. will default to orgId 1 if not specified
		  orgId: 1
		  # <string> url
		  url: http://localhost:8080
		  # <string> database password, if used
		  password:
		  # <string> database user, if used
		  user:
		  # <string> database name, if used
		  database:
		  # <bool> enable/disable basic auth
		  basicAuth:
		  # <string> basic auth username
		  basicAuthUser:
		  # <string> basic auth password
		  basicAuthPassword:
		  # <bool> enable/disable with credentials headers
		  withCredentials:
		  # <bool> mark as default datasource. Max one per org
		  isDefault:
		  # <map> fields that will be converted to json and stored in json_data
		  jsonData:
		     graphiteVersion: "1.1"
		     tlsAuth: true
		     tlsAuthWithCACert: true
		  # <string> json object of data that will be encrypted.
		  secureJsonData:
		    tlsCACert: "..."
		    tlsClientCert: "..."
		    tlsClientKey: "..."
		  version: 1
		  # <bool> allow users to edit datasources from the UI.
		  editable: false

```
# Docker Registry Helm Chart

This directory contains a Kubernetes chart to deploy a private Docker Registry.

## Prerequisites Details

* PV support on underlying infrastructure (if persistence is required)

## Chart Details

This chart will do the following:

* Implement a Docker registry deployment

## Installing the Chart

To install the chart, use the following:

```console
$ helm install beavergithub/docker-registry
```

## Configuration

The following table lists the configurable parameters of the docker-registry chart and
their default values.

| Parameter                   | Description                                                                              | Default         |
|:----------------------------|:-----------------------------------------------------------------------------------------|:----------------|
| `image.pullPolicy`          | Container pull policy                                                                    | `IfNotPresent`  |
| `image.repository`          | Container image to use                                                                   | `registry`      |
| `image.tag`                 | Container image tag to deploy                                                            | `2.6.2`         |
| `persistence.accessMode`    | Access mode to use for PVC                                                               | `ReadWriteOnce` |
| `persistence.enabled`       | Whether to use a PVC for the Docker storage                                              | `false`         |
| `persistence.size`          | Amount of space to claim for PVC                                                         | `10Gi`          |
| `persistence.storageClass`  | Storage Class to use for PVC                                                             | `-`             |
| `persistence.existingClaim` | Name of an existing PVC to use for config                                                | `nil`           |
| `service.port`              | TCP port on which the service is exposed                                                 | `5000`          |
| `service.type`              | service type                                                                             | `ClusterIP`     |
| `service.nodePort`          | if `service.type` is `NodePort` and this is non-empty, sets the node port of the service | `nil`           |
| `replicaCount`              | k8s replicas                                                                             | `1`             |
| `resources.limits.cpu`      | Container requested CPU                                                                  | `nil`           |
| `resources.limits.memory`   | Container requested memory                                                               | `nil`           |
| `storage`                   | Storage system to use                                                                    | `fileststem`    |
| `tlsSecretName`             | Name of secret for TLS certs                                                             | `nil`           |
| `secrets.htpasswd`          | Htpasswd authentication                                                                  | `nil`           |
| `secrets.s3.accessKey`      | Access Key for S3 configuration                                                          | `nil`           |
| `secrets.s3.secretKey`      | Secret Key for S3 configuration                                                          | `nil`           |
| `haSharedSecret`            | Shared secret for Registry                                                               | `nil`           |
| `configData`                | Configuration hash for docker                                                            | `nil`           |
| `s3.region`                 | S3 region                                                                                | `nil`           |
| `s3.bucket`                 | S3 bucket name                                                                           | `nil`           |
| `s3.encrypt`                | Store images in encrypted format                                                         | `nil`           |
| `s3.secure`                 | Use HTTPS                                                                                | `nil`           |
| `ingress.annotations`       | Add kolihub                                                                              | `registry.host.local.dmz`           |

Specify each parameter using the `--set key=value[,key=value]` argument to
`helm install`.

To generate htpasswd file, run this docker command:
`docker run --entrypoint htpasswd registry:2 -Bbn user password > ./htpasswd`.
> This chart is deprecated in favor of the [official GitLab chart](http://docs.gitlab.com/ce/install/kubernetes/gitlab_omnibus.html).

# GitLab Community Edition

[GitLab Community Edition](https://about.gitlab.com/) is an application to code, test, and deploy code together. It provides Git repository management with fine grained access controls, code reviews, issue tracking, activity feeds, wikis, and continuous integration. 

## Introduction

This chart stands up a GitLab Community Edition install. This includes:

- A [GitLab Omnibus](https://docs.gitlab.com/omnibus/) Pod
- Redis
- Postgresql

## Prerequisites

- _At least_ 3 GB of RAM available on your cluster, in chunks of 1 GB
- Kubernetes 1.4+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure
- The ability to point a DNS entry or URL at your GitLab install

## Installing the Chart

To install the chart with the release name `my-release` run:

```bash
$ helm install --name my-release \
    --set externalUrl=http://your-domain.com/ stable/gitlab-ce
```

Note that you _must_ pass in externalUrl, or you'll end up with a non-functioning release.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

Refer to [values.yaml](values.yaml) for the full run-down on defaults. These are a mixture of Kubernetes and GitLab-related directives.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install --name my-release \
    --set externalUrl=http://your-domain.com/,gitlabRootPassword=pass1234 \
    stable/gitlab-ce
```

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml stable/gitlab-ce
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Persistence

By default, persistence of GitLab data and configuration happens using PVCs. If you know that you'll need a larger amount of space, make _sure_ to look at the `persistence` section in [values.yaml](values.yaml).

> *"If you disable persistence, the contents of your volume(s) will only last as long as the Pod does. Upgrading or changing certain settings may lead to data loss without persistence."*
## Account

Template to simple create Accounts
