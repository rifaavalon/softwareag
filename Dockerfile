FROM ubuntu:18.04

RUN \
apt-get update && \
apt-get -y upgrade && \
apt-get install -y build-essential && \
apt-get install -y software-properties-common && \
apt-get install -y byobu curl git htop man unzip vim wget && \
rm -rf /var/lib/apt/lists/*

COPY --from=hashicorp/terraform:0.12.0 /bin/terraform /bin/

COPY . .
