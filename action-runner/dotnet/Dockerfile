FROM mcr.microsoft.com/dotnet/runtime-deps:8.0-jammy as tmp

ARG RUNNER_VERSION=2.331.0
ARG RUNNER_ARCH="x64"
ARG RUNNER_CONTAINER_HOOKS_VERSION=0.8.0

RUN apt update -y && apt install curl unzip -y

WORKDIR /actions-runner
RUN curl -f -L -o runner.tar.gz https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-${RUNNER_ARCH}-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./runner.tar.gz \
    && rm runner.tar.gz

RUN curl -f -L -o runner-container-hooks.zip https://github.com/actions/runner-container-hooks/releases/download/v${RUNNER_CONTAINER_HOOKS_VERSION}/actions-runner-hooks-k8s-${RUNNER_CONTAINER_HOOKS_VERSION}.zip \
    && unzip ./runner-container-hooks.zip -d ./k8s \
    && rm runner-container-hooks.zip

FROM mcr.microsoft.com/dotnet/sdk:8.0-jammy 

ENV DEBIAN_FRONTEND=noninteractive
ENV RUNNER_MANUALLY_TRAP_SIG=1
ENV ACTIONS_RUNNER_PRINT_LOG_TO_STDOUT=1
ENV APP_UID=1001

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
    sudo \
    lsb-release \
    curl \
    wget \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid=$APP_UID runner \
    && adduser --disabled-password --gecos "" --uid $APP_UID -gid=$APP_UID runner \
    && usermod -aG sudo runner \
    && echo "%sudo   ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers \
    && echo "Defaults env_keep += \"DEBIAN_FRONTEND\"" >> /etc/sudoers

WORKDIR /home/runner

COPY --chown=runner:runner --from=tmp /actions-runner .

USER runner