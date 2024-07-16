# Docker

## Installation

- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [Docker Engine](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Docker Machine](https://docs.docker.com/machine/install-machine/)
- [Docker Hub](https://hub.docker.com/)

### Personal Installation

1. Install dependencies by running the following command:
```bash
sudo apt update && sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
```
```bash
# Command for Raspberry Pi
sudo apt-get update && sudo apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common \
     vim \
     fail2ban \
     ntfs-3g
```
2. Add Docker's official GPG key by running the following command:
```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker-archive-keyring.gpg
```
```bash
# Command for Raspberry Pi
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```
3. Set up the stable repository by running the following command:
```bash
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```
```bash
# Command for Raspberry Pi
echo "deb [arch=armhf signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/raspbian bullseye stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
4. Install Docker Engine by running the following command:
```bash
sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io
```
```bash
# Command for Raspberry Pi
sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io
```

5. Add your user to the `docker` group by running the following command:
```bash
sudo groupadd docker && sudo usermod -aG docker $USER && logout && sudo systemctl restart docker
```

## Docker Commands

### Docker Images

- `docker images` - List all images
- `docker images -a` - List all images, including intermediate images
- `docker images -q` - List all image IDs
- `docker images -f dangling=true` - List all dangling images
- `docker rmi <image_id>` - Remove an image
- `docker rmi $(docker images -q)` - Remove all images
- `docker rmi $(docker images -q -f dangling=true)` - Remove all dangling images

### Docker Containers

- `docker ps` - List all running containers
- `docker ps -a` - List all containers
- `docker ps -q` - List all container IDs
- `docker ps -f status=exited` - List all stopped containers
- `docker ps -f status=exited -q` - List all stopped container IDs
- `docker stop <container_id>` - Stop a container
- `docker stop $(docker ps -q)` - Stop all running containers
- `docker rm <container_id>` - Remove a container
- `docker rm $(docker ps -a -q)` - Remove all containers
- `docker rm $(docker ps -a -q -f status=exited)` - Remove all stopped containers

### Docker Volumes

- `docker volume ls` - List all volumes
- `docker volume rm <volume_name>` - Remove a volume
- `docker volume rm $(docker volume ls -q)` - Remove all volumes

### Docker Networks

- `docker network ls` - List all networks
- `docker network rm <network_name>` - Remove a network
- `docker network rm $(docker network ls -q)` - Remove all networks

### Docker System

- `docker system df` - Show Docker disk usage
- `docker system prune` - Remove all unused data
- `docker system prune -a` - Remove all unused data, including stopped containers and unused images

## Dockerfile

### Dockerfile Instructions

- `FROM` - Base image
- `LABEL` - Metadata
- `RUN` - Run a command
- `COPY` - Copy files or directories
- `ADD` - Copy files or directories with extraction support
- `CMD` - Default command or parameters
- `ENTRYPOINT` - Configure a container that will run as an executable
- `WORKDIR` - Working directory
- `ENV` - Environment variable
- `EXPOSE` - Expose ports
- `VOLUME` - Create a mount point
- `USER` - Set the user
- `HEALTHCHECK` - Health check
- `ARG` - Define a build-time variable
- `ONBUILD` - Execute instructions at a later build stage
- `STOPSIGNAL` - Signal to stop a container
- `SHELL` - Shell to use

### Dockerfile Best Practices

- Use `.dockerignore` to exclude unnecessary files and directories
- Use multi-stage builds to reduce image size
- Combine `RUN` commands to reduce image layers
- Use `COPY` instead of `ADD` for copying files
- Use `HEALTHCHECK` to monitor container health
- Use `LABEL` to add metadata to images
- Use `ARG` to pass build-time variables
- Use `ENTRYPOINT` as the main command
- Use `CMD` to provide default arguments for `ENTRYPOINT`
- Use `USER` to run the container as a non-root user
- Use `WORKDIR` to set the working directory
- Use `EXPOSE` to document exposed ports
- Use `VOLUME` to manage persistent data
- Use `STOPSIGNAL` to specify the signal to stop a container

## Docker Compose

### Docker Compose Commands

- `docker-compose up` - Create and start containers
- `docker-compose up -d` - Create and start containers in detached mode
- `docker-compose down` - Stop and remove containers
- `docker-compose ps` - List containers
- `docker-compose logs` - View container logs
- `docker-compose exec <service_name> <command>` - Execute a command in a running container
- `docker-compose build` - Build or rebuild services
- `docker-compose pull` - Pull service images
- `docker-compose restart` - Restart services
- `docker-compose stop` - Stop services
- `docker-compose start` - Start services
- `docker-compose kill` - Force stop services
- `docker-compose rm` - Remove stopped containers
- `docker-compose down -v` - Remove containers and volumes

### Docker Compose Files

- `docker-compose.yml` - Default Compose file
- `docker-compose.override.yml` - Override Compose file
- `docker-compose.prod.yml` - Production Compose file
- `docker-compose.dev.yml` - Development Compose file

### Docker Compose Best Practices

- Use separate Compose files for different environments
- Use environment variables in Compose files
- Use named volumes for persistent data
- Use service dependencies to control startup order
- Use health checks to monitor container health
- Use `depends_on` to control service startup order
- Use `restart` to configure service restart behavior
- Use `networks` to isolate services
- Use `ports` to expose container ports
- Use `volumes` to manage persistent data
- Use `environment` to set environment variables
- Use `build` to build images from Dockerfiles
- Use `image` to specify pre-built images
