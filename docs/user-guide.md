# User Guide

Initial setup tasks for MacBook.

## MacBook Setup

Add the following to your `/etc/hosts` file...

```bash
127.0.0.1 grafana.observability.kubernetes.internal
127.0.0.1 vault.observability.kubernetes.internal
127.0.0.1 argocd.observability.kubernetes.internal
127.0.0.1 loki.observability.kubernetes.internal
127.0.0.1 tempo.observability.kubernetes.internal
127.0.0.1 mimir.observability.kubernetes.internal
127.0.0.1 victoria-metrics.observability.kubernetes.internal
```

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) (required for local kind cluster)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (required by various scripts)
- [argocd](https://argo-cd.readthedocs.io/en/stable/cli_installation/) (required by various scripts)
- [vault cli](https://www.vaultproject.io/docs/install) (required by various scripts)
- [jq](https://stedolan.github.io/jq/download/) (required by various scripts)
- [yq](https://mikefarah.gitbook.io/yq/) (required by various scripts)
- [openssl](https://www.openssl.org/source/) (required to generate cluster certificate)
- [direnv](https://direnv.net/docs/installation.html) (required to use .envrc)
- [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installing-from-release-binaries) (required to run k8s clusters)

### GitHub Setup

Create a confi repository using the [template repository](https://github.com/pc-dae/mac-template) and update the `.envrc` file with the correct values for your environment.

You will need two fine grain PAT tokens, one with write permission on your config repository and one with read access on this repository and your configuration respository.

Update `secrets/github-secrets.sh` in your configuration repository containing...

```
export GITHUB_TOKEN_WRITE=github_pat_...
export GITHUB_TOKEN_READ=github_pat_...
```

## Deployment

Do `direnv allow` to source the `.envrc` file and then run the `setup.sh` script.
