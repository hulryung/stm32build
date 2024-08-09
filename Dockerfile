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
