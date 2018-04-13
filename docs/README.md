
## Beaver Deployment Helm Chart

This repository includes first step of Beaver Deployment Helm Chart. 
It includes a working Docker build and a deployment for kubernetes.


### Install

```
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



## PostgreSQL

[PostgreSQL](https://postgresql.org) is a powerful, open source object-relational database system. It has more than 15 years of active development and a proven architecture that has earned it a strong reputation for reliability, data integrity, and correctness.

## TL;DR;

```bash
helm install --namespace testdb --name testpostgres --set postgresUser=user --set postgresPassword=secretpassword --set postgresDatabase=mydatabase beavergithub/postgresql --wait
```

## Introduction

This chart bootstraps a [PostgreSQL](https://github.com/docker-library/postgres) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure (Only when persisting data)

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release beavergithub/postgresql
```

The command deploys PostgreSQL on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the PostgreSQL chart and their default values.

| Parameter                  | Description                                     | Default                                                    |
| -----------------------    | ---------------------------------------------   | ---------------------------------------------------------- |
| `image`                    | `postgres` image repository                     | `postgres`                                                 |
| `imageTag`                 | `postgres` image tag                            | `9.6.2`                                                    |
| `imagePullPolicy`          | Image pull policy                               | `Always` if `imageTag` is `latest`, else `IfNotPresent`    |
| `imagePullSecrets`         | Image pull secrets                              | `nil`                                                      |
| `postgresUser`             | Username of new user to create.                 | `postgres`                                                 |
| `postgresPassword`         | Password for the new user.                      | random 10 characters                                       |
| `postgresDatabase`         | Name for new database to create.                | `postgres`                                                 |
| `postgresInitdbArgs`       | Initdb Arguments                                | `nil`                                                      |
| `schedulerName`            | Name of an alternate scheduler                  | `nil`                                                      |
| `postgresConfig`           | Runtime Config Parameters                       | `nil`                                                      |
| `persistence.enabled`      | Use a PVC to persist data                       | `true`                                                     |
| `persistence.existingClaim`| Provide an existing PersistentVolumeClaim       | `nil`                                                      |
| `persistence.storageClass` | Storage class of backing PVC                    | `nil` (uses alpha storage class annotation)                |
| `persistence.accessMode`   | Use volume as ReadOnly or ReadWrite             | `ReadWriteOnce`                                            |
| `persistence.annotations`  | Persistent Volume annotations                   | `{}`                                                       |
| `persistence.size`         | Size of data volume                             | `4Gi`                                                      |
| `persistence.subPath`      | Subdirectory of the volume to mount at          | `postgresql-db`                                            |
| `persistence.mountPath`    | Mount path of data volume                       | `/var/lib/postgresql/data/pgdata`                          |
| `resources`                | CPU/Memory resource requests/limits             | Memory: `256Mi`, CPU: `100m`                               |
| `metrics.enabled`          | Start a side-car prometheus exporter            | `false`                                                    |
| `metrics.image`            | Exporter image                                  | `wrouesnel/postgres_exporter`                              |
| `metrics.imageTag`         | Exporter image                                  | `v0.1.1`                                                   |
| `metrics.imagePullPolicy`  | Exporter image pull policy                      | `IfNotPresent`                                             |
| `metrics.resources`        | Exporter resource requests/limit                | Memory: `256Mi`, CPU: `100m`                               |
| `metrics.customMetrics`    | Additional custom metrics                       | `nil`                                                      |
| `service.externalIPs`      | External IPs to listen on                       | `[]`                                                       |
| `service.port`             | TCP port                                        | `5432`                                                     |
| `service.type`             | k8s service type exposing ports, e.g. `NodePort`| `ClusterIP`                                                |
| `service.nodePort`         | NodePort value if service.type is `NodePort`    | `nil`                                                      |
| `networkPolicy.enabled`    | Enable NetworkPolicy                            | `false`                                                    |
| `networkPolicy.allowExternal` | Don't require client label for connections   | `true`                                                     |
| `nodeSelector`             | Node labels for pod assignment                  | {}                                                         |
| `affinity`                 | Affinity settings for pod assignment            | {}                                                         |
| `tolerations`              | Toleration labels for pod assignment            | []                                                         |
| `backup.enabled`           | pghoard Backup enabled                          | `true`                                                     |
| `backup.user`              | Backup default user                             | `repuser`                                                  |
| `backup.password`          | Backup default password                         | `reppassword`                                              |
| `backup.storage_type`      | Backup default storage_type                     | `local`                                                    |
| `backup.directory`         | Backup directory                                | `/backup/`                                                 |
| `backup.persistent`        | Enable persistent                               | `false`                                                    |
| `backup.storageClassName`  | Storage class of backing                        | `manual`                                                   |
| `backup.storageSize`       | Size of data volume                             | `4Gi`                                                      |

The above parameters map to the env variables defined in [postgres](http://github.com/docker-library/postgres). For more information please refer to the [postgres](http://github.com/docker-library/postgres) image documentation.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install --name my-release \
  --set postgresUser=my-user,postgresPassword=secretpassword,postgresDatabase=my-database \
    beavergithub/postgresql
```

The above command creates a PostgreSQL user named `my-user` with password `secretpassword`. Additionally it creates a database named `my-database`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml beavergithub/postgresql
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Persistence

The [postgres](https://github.com/docker-library/postgres) image stores the PostgreSQL data and configurations at the `/var/lib/postgresql/data/pgdata` path of the container.

The chart mounts a [Persistent Volume](http://kubernetes.io/docs/user-guide/persistent-volumes/) volume at this location. The volume is created using dynamic volume provisioning. If the PersistentVolumeClaim should not be managed by the chart, define `persistence.existingClaim`.

### Existing PersistentVolumeClaims

1. Create the PersistentVolume
1. Create the PersistentVolumeClaim
1. Install the chart
```bash
$ helm install --set persistence.existingClaim=PVC_NAME postgresql
```

The volume defaults to mount at a subdirectory of the volume instead of the volume root to avoid the volume's hidden directories from interfering with `initdb`.  If you are upgrading this chart from before version `0.4.0`, set `persistence.subPath` to `""`.

## Metrics
The chart optionally can start a metrics exporter for [prometheus](https://prometheus.io). The metrics endpoint (port 9187) is not exposed and it is expected that the metrics are collected from inside the k8s cluster using something similar as the described in the [example Prometheus scrape configuration](https://github.com/prometheus/prometheus/blob/master/documentation/examples/prometheus-kubernetes.yml).

The exporter allows to create custom metrics from additional SQL queries. See the Chart's `values.yaml` for an example and consult the [exporters documentation](https://github.com/wrouesnel/postgres_exporter#adding-new-metrics-via-a-config-file) for more details.

## NetworkPolicy

To enable network policy for PostgreSQL,
install [a networking plugin that implements the Kubernetes
NetworkPolicy spec](https://kubernetes.io/docs/tasks/administer-cluster/declare-network-policy#before-you-begin),
and set `networkPolicy.enabled` to `true`.

For Kubernetes v1.5 & v1.6, you must also turn on NetworkPolicy by setting
the DefaultDeny namespace annotation. Note: this will enforce policy for _all_ pods in the namespace:

    kubectl annotate namespace default "net.beta.kubernetes.io/network-policy={\"ingress\":{\"isolation\":\"DefaultDeny\"}}"

With NetworkPolicy enabled, traffic will be limited to just port 5432.

For more precise policy, set `networkPolicy.allowExternal=false`. This will
only allow pods with the generated client label to connect to PostgreSQL.
This label will be displayed in the output of a successful install.
## MariaDB

[MariaDB](https://mariadb.org) is one of the most popular database servers in the world. It’s made by the original developers of MySQL and guaranteed to stay open source. Notable users include Wikipedia, Facebook and Google.

MariaDB is developed as open source software and as a relational database, it provides an SQL interface for accessing data. The latest versions of MariaDB also include GIS and JSON features.


```bash
helm install --namespace testdb --name testmysql --set mariadbRootPassword=secretpassword,mariadbUser=myuser,mariadbPassword=my-password,mariadbDatabase=mydatabase beavergithub/mariadb --wait --debug
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the MariaDB chart and their default values.

|          Parameter           |                Description                 |                   Default                   |
| ---------------------------- | ------------------------------------------ | ------------------------------------------- |
| `image`                      | MariaDB image                              | `bitnami/mariadb:{VERSION}`                 |
| `service.type`               | Kubernetes service type to expose          | `ClusterIP`                                 |
| `service.nodePort`           | Port to bind to for NodePort service type  | `nil`                                       |
| `service.annotations`        | Additional annotations to add to service   | `nil`                                       |
| `imagePullPolicy`            | Image pull policy.                         | `IfNotPresent`                              |
| `usePassword`                | Enable password authentication             | `true`                                      |
| `mariadbRootPassword`        | Password for the `root` user.              | Randomly generated                          |
| `mariadbUser`                | Username of new user to create.            | `nil`                                       |
| `mariadbPassword`            | Password for the new user.                 | `nil`                                       |
| `mariadbDatabase`            | Name for new database to create.           | `nil`                                       |
| `persistence.enabled`        | Use a PVC to persist data                  | `true`                                      |
| `persistence.existingClaim`  | Use an existing PVC                        | `nil`                                       |
| `persistence.storageClass`   | Storage class of backing PVC               | `nil` (uses alpha storage class annotation) |
| `persistence.accessMode`     | Use volume as ReadOnly or ReadWrite        | `ReadWriteOnce`                             |
| `persistence.size`           | Size of data volume                        | `8Gi`                                       |
| `resources`                  | CPU/Memory resource requests/limits        | Memory: `256Mi`, CPU: `250m`                |
| `config`                     | Multi-line string for my.cnf configuration | `nil`                                       |
| `metrics.enabled`            | Start a side-car prometheus exporter       | `false`                                     |
| `metrics.image`              | Exporter image                             | `prom/mysqld-exporter`                      |
| `metrics.imageTag`           | Exporter image                             | `v0.10.0`                                   |
| `metrics.imagePullPolicy`    | Exporter image pull policy                 | `IfNotPresent`                              |
| `metrics.resources`          | Exporter resource requests/limit           | `nil`                                       |
| `securitySettings.runAsUser` | DAC UID for containers in this Deployment  | `1001`                                      |
| `securitySettings.fsGroup`   | DAC GID for containers in this Deployment  | `1001`                                      |

The above parameters map to the env variables defined in [bitnami/mariadb](http://github.com/bitnami/bitnami-docker-mariadb). For more information please refer to the [bitnami/mariadb](http://github.com/bitnami/bitnami-docker-mariadb) image documentation.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install --name my-release \
  --set mariadbRootPassword=secretpassword,mariadbUser=my-user,mariadbPassword=my-password,mariadbDatabase=my-database \
    beavergithub/mariadb
```

The above command sets the MariaDB `root` account password to `secretpassword`. Additionally, it creates a standard database user named `my-user`, with the password `my-password`, who has access to a database named `my-database`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml beavergithub/mariadb
```

> **Tip**: You can use the default [values.yaml](values.yaml)

### Custom my.cnf configuration

The Bitnami MariaDB image allows you to provide a custom `my.cnf` file for configuring MariaDB.
This Chart uses the `config` value to mount a custom `my.cnf` using a [ConfigMap](http://kubernetes.io/docs/user-guide/configmap/).
You can configure this by creating a YAML file that defines the `config` property as a multi-line string in the format of a `my.cnf` file.
For example:

```bash
cat > mariadb-values.yaml <<EOF
config: |-
  [mysqld]
  max_allowed_packet = 64M
  sql_mode=STRICT_ALL_TABLES
  ft_stopword_file=/etc/mysql/stopwords.txt
  ft_min_word_len=3
  ft_boolean_syntax=' |-><()~*:""&^'
  innodb_buffer_pool_size=2G
EOF

helm install --name my-release -f mariadb-values.yaml beavergithub/mariadb
```

## Consuming credentials

To connect to your database in your application, you can consume the credentials from the secret. For example:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-app
spec:
  containers:
    - name: my-app
      image: bitnami/mariadb:latest
      env:
        - name: MARIADB_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: my-release-mariadb
              key: mariadb-root-password
      command: ["sh", "-c"]
      args:
      - mysql -h my-release-mariadb.default.svc.cluster.local -p$MARIADB_ROOT_PASSWORD -e 'show databases;'
  restartPolicy: Never

```

## Persistence

The [Bitnami MariaDB](https://github.com/bitnami/bitnami-docker-mariadb) image stores the MariaDB data and configurations at the `/bitnami/mariadb` path of the container.

The chart mounts a [Persistent Volume](http://kubernetes.io/docs/user-guide/persistent-volumes/) volume at this location. The volume is created using dynamic volume provisioning, by default. An existing PersistentVolumeClaim can be defined.

### Existing PersistentVolumeClaims

1. Create the PersistentVolume
1. Create the PersistentVolumeClaim
1. Install the chart

```bash
$ helm install --set persistence.existingClaim=PVC_NAME postgresql
```

## Metrics

The chart can optionally start a metrics exporter endpoint on port `9104` for [prometheus](https://prometheus.io). The data exposed by the endpoint is intended to be consumed by a prometheus chart deployed within the cluster and as such the endpoint is not exposed outside the cluster.
## Redis

[Redis](http://redis.io/) is an advanced key-value cache and store. It is often referred to as a data structure server since keys can contain strings, hashes, lists, sets, sorted sets, bitmaps and hyperloglogs.

## TL;DR;

```bash
$ helm install beavergithub/redis
```

## Introduction

This chart bootstraps a [Redis](https://github.com/bitnami/bitnami-docker-redis) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release beavergithub/redis
```

The command deploys Redis on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the Redis chart and their default values.

|           Parameter           |                Description                        |           Default            |
|-------------------------------|-------------------------------------------------- |------------------------------|
| `image`                       | Redis image                                       | `bitnami/redis:{VERSION}`    |
| `imagePullPolicy`             | Image pull policy                                 | `IfNotPresent`               |
| `serviceType`                 | Kubernetes Service type                           | `ClusterIP`                  |
| `usePassword`                 | Use password                                      | `true`                       |
| `redisPassword`               | Redis password                                    | Randomly generated           |
| `redisDisableCommands`        | Comma-separated list of Redis commands to disable | `FLUSHDB,FLUSHALL`           |
| `args`                        | Redis command-line args                           | []                           |
| `redisExtraFlags`             | Redis additional command line flags               | []                           |
| `persistence.enabled`         | Use a PVC to persist data                         | `true`                       |
| `persistence.path`            | Path to mount the volume at, to use other images  | `/bitnami`                   |
| `persistence.subPath`         | Subdirectory of the volume to mount at            | `""`                         |
| `persistence.existingClaim`   | Use an existing PVC to persist data               | `nil`                        |
| `persistence.storageClass`    | Storage class of backing PVC                      | `generic`                    |
| `persistence.accessMode`      | Use volume as ReadOnly or ReadWrite               | `ReadWriteOnce`              |
| `persistence.size`            | Size of data volume                               | `8Gi`                        |
| `resources`                   | CPU/Memory resource requests/limits               | Memory: `256Mi`, CPU: `100m` |
| `metrics.enabled`             | Start a side-car prometheus exporter              | `false`                      |
| `metrics.image`               | Exporter image                                    | `oliver006/redis_exporter`   |
| `metrics.imageTag`            | Exporter image                                    | `v0.11`                      |
| `metrics.imagePullPolicy`     | Exporter image pull policy                        | `IfNotPresent`               |
| `metrics.resources`           | Exporter resource requests/limit                  | Memory: `256Mi`, CPU: `100m` |
| `nodeSelector`                | Node labels for pod assignment                    | {}                           |
| `tolerations`                 | Toleration labels for pod assignment              | []                           |
| `networkPolicy.enabled`       | Enable NetworkPolicy                              | `false`                      |
| `networkPolicy.allowExternal` | Don't require client label for connections        | `true`                       |
| `service.annotations`         | annotations for redis service                     | {}                           |
| `service.loadBalancerIP`      | loadBalancerIP if service type is `LoadBalancer`  | ``                           |
| `securityContext.enabled`     | Enable security context                           | `true`                       |

The above parameters map to the env variables defined in [bitnami/redis](http://github.com/bitnami/bitnami-docker-redis). For more information please refer to the [bitnami/redis](http://github.com/bitnami/bitnami-docker-redis) image documentation.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install --name my-release \
  --set redisPassword=secretpassword \
    beavergithub/redis
```

The above command sets the Redis server password to `secretpassword`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml beavergithub/redis
```

> **Tip**: You can use the default [values.yaml](values.yaml)
> **Note for minikube users**: Current versions of minikube (v0.24.1 at the time of writing) provision `hostPath` persistent volumes that are only writable by root. Using chart defaults cause pod failure for the Redis pod as it attempts to write to the `/bitnami` directory. Consider installing Redis with `--set persistence.enabled=false`. See minikube issue [1990](https://github.com/kubernetes/minikube/issues/1990) for more information.

## NetworkPolicy

To enable network policy for Redis, install
[a networking plugin that implements the Kubernetes NetworkPolicy spec](https://kubernetes.io/docs/tasks/administer-cluster/declare-network-policy#before-you-begin),
and set `networkPolicy.enabled` to `true`.

For Kubernetes v1.5 & v1.6, you must also turn on NetworkPolicy by setting
the DefaultDeny namespace annotation. Note: this will enforce policy for _all_ pods in the namespace:

    kubectl annotate namespace default "net.beta.kubernetes.io/network-policy={\"ingress\":{\"isolation\":\"DefaultDeny\"}}"

With NetworkPolicy enabled, only pods with the generated client label will be
able to connect to Redis. This label will be displayed in the output
after a successful install.

## Persistence

The [Bitnami Redis](https://github.com/bitnami/bitnami-docker-redis) image stores the Redis data and configurations at the `/bitnami` path of the container.

By default, the chart mounts a [Persistent Volume](http://kubernetes.io/docs/user-guide/persistent-volumes/) volume at this location. The volume is created using dynamic volume provisioning. If a Persistent Volume Claim already exists, specify it during installation.

### Existing PersistentVolumeClaim

1. Create the PersistentVolume
1. Create the PersistentVolumeClaim
1. Install the chart

```bash
$ helm install --set persistence.existingClaim=PVC_NAME redis
```

## Metrics

The chart optionally can start a metrics exporter for [prometheus](https://prometheus.io). The metrics endpoint (port 9121) is exposed in the service. Metrics can be scraped from within the cluster using something similar as the described in the [example Prometheus scrape configuration](https://github.com/prometheus/prometheus/blob/master/documentation/examples/prometheus-kubernetes.yml). If metrics are to be scraped from outside the cluster, the Kubernetes API proxy can be utilized to access the endpoint.
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
