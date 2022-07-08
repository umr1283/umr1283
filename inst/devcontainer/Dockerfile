ARG IMAGE
FROM ${IMAGE}

RUN apt-get update && apt-get install -y openssh-client sudo

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
        ${USERNAME} \
    && usermod -aG sudo ${USERNAME} \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN Rscript -e 'pak::pkg_install(c("languageserver", "httpgd"))'

USER ${USERNAME}