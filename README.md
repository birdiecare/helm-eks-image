# helm-base-image

This image is meant to be used as a runner in [birdiecare/helm-eks-action](https://github.com/birdiecare/helm-eks-action).
It bundles common utilities needed for managing helm deployments in a pipeline.

- AWS CLI v2
- Helm v3
- SOPS

Versions can be configured using build args

| Arg             | Default  |
|-----------------|----------|
| AWS_CLI_VERSION | "2.0.59" |
| KUBECTL_VERSION | "1.19.3" |
| HELM_VERSION    | "3.4.2"  |
| SOPS_VERSION    | "3.6.1"  |

It accepts 3 environment variables

| Variable         | Description                           | Example                                           |
|------------------|---------------------------------------|---------------------------------------------------|
| KUBE_CONFIG_DATA | base64 encoded kube config            |                                                   |
| INPUT_REPOS      | '\n' separated list of name url pairs | "stable https://charts.helm.sh/stable"            |
| INPUT_PLUGINS    | '\n' separated list of plugin repos   | "https://github.com/jkroepke/helm-secrets@v3.4.0" |


