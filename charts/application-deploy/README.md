## Configuration

Parameter | Description | Default
--- | --- | ---
`deployment.enabled` | |
`env` | |
`image.pullPolicy` | |
`image.repository` | |
`image.tag` | |
`ingress.class` | |
`ingress.config.enabled` | |
`ingress.enabled` | Enable ingress for app | `true`
`ingress.fqdn` | |
`ingress.path` | | `/`
`metrics.enabled` | Enable [Prometheus] metrics | `true`
`metrics.path` | Path for [Prometheus] metrics | `/metrics`
`plugin.correlation.enabled` | Enable [Correlation ID] | `true`
`replicaCount` | Number of running instances | `1`
`revisionHistoryLimit` | |
`secrets` | | `[]`
`service.enabled` | |
`service.externalPort` | External application port *(required)* |
`service.internalPort` | Internal container port *(required)* |
`service.name` | |

[Prometheus]: https://prometheus.io
[Correlation ID]: https://docs.konghq.com/plugins/correlation-id/
