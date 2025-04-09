FROM mcr.microsoft.com/azure-functions/python:4-python3.11
LABEL maintainer="sre@signiant.com"

#azure functions tools
RUN apt-get update && \
    apt-get install -y curl gpg python3 python3-pip figlet jq zip git && \
    apt install -y lsb-release && \
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg && \
    echo "deb [arch=amd64] https://packages.microsoft.com/debian/$(lsb_release -rs | cut -d'.' -f 1)/prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list && \
    apt-get update && \
    apt-get install -y azure-functions-core-tools-4 && \
    rm -rf /var/lib/apt/lists/*

# Azure CLI
COPY pip.packages.list /tmp/pip.packages.list
RUN python3 -m pip install -r /tmp/pip.packages.list && \
    az bicep install
