ARG IMAGE
FROM ${IMAGE}

ARG USERNAME=umr1283
ARG USERID=1000
RUN apt-get update \
    && apt-get install -y openssh-client sudo \
    && if [[ -d /home/${USERNAME} ]]; then CH="--no-create-home"; else CH="--create-home"; fi \
    && useradd \
        ${CH} \
        --no-user-group \
        --shell /bin/bash \
        --uid ${USERID} \
        --gid staff \
        --groups staff \
        ${USERNAME} \
    && usermod -aG sudo ${USERNAME} \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# RUN Rscript -e 'pak::pkg_install(c("languageserver", "httpgd"))'

USER ${USERNAME}
