
FROM ubuntu:xenial

LABEL MAINTAINER="Gabriel Stein <gabrie.g.stein@gmail.com>"

# BLOCO NECESSÁRIO APENAS PARA CRIAR A IMAGEM NO INCRA -------------------------------------
# RUN apt-get update
# RUN apt-get install -y ca-certificates
# RUN ls /usr/local/share/ca-certificates/
# RUN rm -rf /var/cache/apt/* && mkdir /usr/local/share/ca-certificates/incra && mkdir -p /usr/local/share/ca-certificates/registry-1.docker.io:443

# COPY ./checkpoint.crt /etc/docker/certs.d/registry-1.docker.io:443
# COPY ./incra.crt /etc/docker/certs.d/registry-1.docker.io:443
# COPY ./checkpoint.crt /usr/local/share/ca-certificates/checkpoint.crt
# COPY ./incra.crt /usr/local/share/ca-certificates/incra.crt
# COPY ./registry-1.docker.io.crt /usr/local/share/ca-certificates/registry-1.docker.io:443

# RUN update-ca-certificates
# BLOCO NECESSÁRIO APENAS PARA CRIAR A IMAGEM NO INCRA -------------------------------------


ARG NODEJS_VERSION="10"
ARG ANDROID_SDK_VERSION="3859397"
ARG ANDROID_HOME="/opt/android-sdk"
ARG ANDROID_BUILD_TOOLS_VERSION="26.0.2"

ENV ANDROID_HOME "${ANDROID_HOME}"

# Install system package dependencies
RUN apt-get update \
    && apt-get install -y \
    build-essential \
    openjdk-8-jre \
    openjdk-8-jdk \
    curl \
    unzip \
    git \
    gradle

# Install Nodejs/NPM/Ionic-Cli
RUN && curl -sL https://deb.nodesource.com/setup_${NODEJS_VERSION}.x | bash - \
    && apt-get update \
    && apt-get install -y nodejs \
    && npm install -g cordova @ionic/cli

# Install Android SDK
# Install SDK tool for support ionic build command
# Cleanup
RUN cd /tmp \
    && curl -fSLk https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip -o sdk-tools-linux-${ANDROID_SDK_VERSION}.zip \
    && unzip sdk-tools-linux-${ANDROID_SDK_VERSION}.zip \
    && mkdir /opt/android-sdk \
    && mv tools /opt/android-sdk \
    && (while sleep 3; do echo "y"; done) | $ANDROID_HOME/tools/bin/sdkmanager --licenses \
    && $ANDROID_HOME/tools/bin/sdkmanager "platform-tools" \
    && $ANDROID_HOME/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
    && apt-get autoremove -y \
    && rm -rf /tmp/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip \ 
    && mkdir /ionicapp

WORKDIR /ionicapp