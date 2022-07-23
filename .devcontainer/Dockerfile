ARG DEBIAN_RELEASE=stable
FROM debian:${DEBIAN_RELEASE}

RUN apt-get update \
    && apt-get install --no-install-recommends --yes ca-certificates wget \
    gpg openssh-server apt-transport-https sudo bash-completion git

RUN wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub \
    | gpg --dearmor -o /usr/share/keyrings/dart.gpg \
    && echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' \
    | tee /etc/apt/sources.list.d/dart_stable.list

RUN apt-get update && apt-get install --no-install-recommends --yes dart \
    && apt-get clean

ARG USERNAME=dev
ARG UID=1000
ARG GID=${UID}

RUN groupadd --gid ${GID} ${USERNAME} \
    && useradd --uid ${UID} --gid ${GID} -m ${USERNAME} \
    && usermod --shell /bin/bash ${USERNAME} \
    && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

USER ${USERNAME}
RUN echo 'PATH="$PATH":"$HOME/.pub-cache/bin"' >> "$HOME/.bash_profile" \
    && dart --disable-analytics \
    && dart pub global activate pana
