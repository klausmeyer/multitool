# Multitool

Docker image preinstalled with some goodies:

* Docker
* Kubectl
* Helm
* jq / yq

## Usage Examples

### Docker

```shell
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock klausmeyer/multitool:latest bash
```

### Kubectl

```shell
docker run -it --rm -v "$HOME/.kube:/root/.kube" klausmeyer/multitool:latest bash
```
