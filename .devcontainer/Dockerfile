# GO_VERSION and TZ are injected by docker-compose.dev.yml
ARG GO_VERSION=1.26

FROM mcr.microsoft.com/devcontainers/go:2-${GO_VERSION}-trixie AS development

ARG TZ=America/Belem

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=${TZ}

# The yarn apt repository shipped with this image has a broken signature on Trixie
RUN rm -f /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y \
    fish \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone

# fish becomes the default shell in post-create.sh, after the image is built.
# Changing it here breaks tools that run `su vscode -c "..."` with a POSIX script.

USER vscode

CMD ["fish"]
