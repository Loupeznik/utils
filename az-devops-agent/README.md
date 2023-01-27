# Azure DevOps private agent

The Dockerfile will build the Docker image for a Azure DevOps agent in case the agent cannot be ran on the host directly.

The `/opt` directory is exposed and can be mounted as a volume.

Example usage:

```bash
sudo docker build -t docker-devops-agent:latest .
sudo docker run -e AZP_URL=https://dev.azure.com/organization \
-e AZP_TOKEN=token \
-e AZP_AGENT_NAME=hostname \
-e AZP_POOL=test \
-v /opt:/opt \
--name az-devops-agent \
-d --restart=unless-stopped docker-devops-agent:latest
```

For architectures other than x64, refer to [Microsoft documentation](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops#create-and-build-the-dockerfile-1) and change the `TARGETARCH` environment variable in the Dockerfile.
