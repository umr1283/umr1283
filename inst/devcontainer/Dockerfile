FROM docker.io/umr1283/umr1283:4.2.0

ARG USERNAME=umr1283
ARG USERID=1000
RUN if [[ -d /home/${USERNAME} ]]; then CH="--no-create-home"; else CH="--create-home"; fi \
    && useradd \
        ${CH} \
        --no-user-group \
        --shell /bin/bash \
        --uid ${USERID} \
        --gid staff \
        --groups staff \
        ${USERNAME}

RUN apt-get update && apt-get install -y openssh-client

USER ${USERNAME}
