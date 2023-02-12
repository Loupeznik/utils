# Azure DevOps Agent for PHP

Self-hosted Azure DevOps agent for PHP workloads. Comes with PHP preinstalled.

Supported PHP versions:

- PHP 8.1
- PHP 7.4

## Building

```bash
docker build -t azure-devops-agent-php:7.4-amd64 -f ".\Dockerfile.php74" ..

# to define custom architecture
docker build -t azure-devops-agent-php:8.1-arm64 --build-arg ARCH=linux-arm64 -f ".\Dockerfile.php81" .. 
```

## Running a pre-build image

[![DockerHub](https://img.shields.io/badge/-Get%20the%20image%20from%20Dockerhub-blue?style=for-the-badge&logo=docker&color=grey)](https://hub.docker.com/r/loupeznik/azure-devops-agent-php)
![Docker Pulls](https://img.shields.io/docker/pulls/loupeznik/azure-devops-agent-php?style=for-the-badge)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/loupeznik/azure-devops-agent-php?style=for-the-badge)

````bash
sudo docker run -e AZP_URL=https://dev.azure.com/organization \
-e AZP_TOKEN=token \
-e AZP_AGENT_NAME=hostname \
-e AZP_POOL=test \
-v /opt:/opt \
--name az-devops-agent \
-d --restart=unless-stopped loupeznik/azure-devops-agent-php:8.1-amd64
```
