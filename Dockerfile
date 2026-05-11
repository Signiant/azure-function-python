FROM mcr.microsoft.com/azure-functions/python:4-python3.14
LABEL maintainer="sre@signiant.com"

# Azure functions tools
RUN apt-get update && \
    apt-get install -y curl gpg figlet jq zip git lsb-release && \
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg && \
    echo "deb [arch=amd64] https://packages.microsoft.com/ubuntu/$(lsb_release -rs)/prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list && \
    apt-get update && \
    apt-get install -y azure-functions-core-tools-4 && \
    rm -rf /var/lib/apt/lists/*

# Azure CLI
ENV PATH="/opt/python/3/bin:${PATH}"
COPY pip.packages.list /tmp/pip.packages.list
RUN python3 -m pip install -r /tmp/pip.packages.list && \
    az bicep install
