# ARM GCC GitHub Container Registry (GHCR) Setup

This repository demonstrates how to register a container using ARM GCC (arm-none-eabi-gcc) on GitHub Container Registry (GHCR). Follow this guide to create and push your own GHCR container.

## Prerequisites

- Docker installed
- GitHub account
- Personal Access Token (PAT)

## Preparing the Dockerfile

First, clone this repository and navigate to the directory:

```bash
git clone https://github.com/YOUR_USERNAME/arm-gcc-ghcr.git
cd arm-gcc-ghcr
```

Create a Dockerfile in this directory with the following content:

```dockerfile
FROM ubuntu:22.04

RUN apt update && apt upgrade -y
RUN apt-get install -y clang python3 python3-pip python3-venv libncurses5 cmake build-essential
RUN apt-get install -y gcc-arm-none-eabi

# Setup the timezone non-interactively so we don't need to in the install
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata

# Set timezone to Seoul
RUN ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# 로그인 셸을 시작하는 ENTRYPOINT 설정
ENTRYPOINT ["/bin/bash", "-c"]
```

## Building the Docker Image

Build the Docker image using the following command:

```bash
docker build -t ghcr.io/USERNAME/arm-gcc:0.1 ./
```

Replace `USERNAME` with your GitHub username.

## Logging in to GitHub Container Registry

1. [Generate a Personal Access Token](https://github.com/settings/tokens)
   - Ensure it has `write:packages` permissions.

2. Log in using the generated token:

```bash
echo "YOUR_PAT" | docker login ghcr.io -u USERNAME --password-stdin
```

Replace `YOUR_PAT` with your generated token and `USERNAME` with your GitHub username.

## Pushing the Docker Image

Push the built image to GHCR:

```bash
docker push ghcr.io/USERNAME/arm-gcc:0.1
```

## Version Management

When releasing a new version, build and push with a new tag. For example:

```bash
docker build -t ghcr.io/USERNAME/arm-gcc:0.2 ./
docker push ghcr.io/USERNAME/arm-gcc:0.2
```

## Usage

To use this container:

```bash
docker pull ghcr.io/USERNAME/arm-gcc:0.1
docker run -it ghcr.io/USERNAME/arm-gcc:0.1
```

Inside the container, you can use arm-none-eabi-gcc and related tools.

## Notes

- Replace `USERNAME` with your GitHub username.
- Manage version numbers appropriately.
- Modify the Dockerfile contents to suit your project needs, such as adding additional tools or changing the ARM GCC version.

You can create and manage your own ARM GCC GHCR container by referring to this guide.
