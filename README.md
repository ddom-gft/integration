# amis-ocra-iac

This repository implements the IaC as source code and additional resources to init, plan, apply and destroy the Ocra Virtual infrastructure for each environment.

## Requirements

- Docker 20

## Contributing

### Git config

```bash
$ git config --local "user.name" "mygithubusername"
```

```bash
$ git config --local "user.email" "myemail@companydomain"
```
## Environments

```bash
- dev
- sit
- uat
- prod
```

## Executing

- Init

```bash
$ docker run \
    -u $(id -u):$(grep -w docker /etc/group | awk -F\: '{print $3}') \
    --rm \
    -w $(pwd) \
    -v /etc/group:/etc/group:ro \
    -v /etc/passwd:/etc/passwd:ro \
    -v $(pwd):$(pwd) \
    -v ${HOME}/.gcp:${HOME}/.gcp \
    hashicorp/terraform:0.12.26 \
    init
```

- Plan

```bash
$ docker run \
    -u $(id -u):$(grep -w docker /etc/group | awk -F\: '{print $3}') \
    --rm \
    -w $(pwd) \
    -v /etc/group:/etc/group:ro \
    -v /etc/passwd:/etc/passwd:ro \
    -v $(pwd):$(pwd) \
    -v ${HOME}/.gcp:${HOME}/.gcp \
    hashicorp/terraform:0.12.26 \
    plan
```

- Apply

```bash
$ docker run \
    -u $(id -u):$(grep -w docker /etc/group | awk -F\: '{print $3}') \
    --rm \
    -w $(pwd) \
    -v /etc/group:/etc/group:ro \
    -v /etc/passwd:/etc/passwd:ro \
    -v $(pwd):$(pwd) \
    -v ${HOME}/.gcp:${HOME}/.gcp \
    hashicorp/terraform:0.12.26 \
    apply -auto-approve
```

- Destroy

```bash
$ docker run -it \
    -u $(id -u):$(grep -w docker /etc/group | awk -F\: '{print $3}') \
    --rm \
    -w $(pwd) \
    -v /etc/group:/etc/group:ro \
    -v /etc/passwd:/etc/passwd:ro \
    -v $(pwd):$(pwd) \
    -v ${HOME}/.gcp:${HOME}/.gcp \
    hashicorp/terraform:0.12.26 \
    destroy -auto-approve
```
