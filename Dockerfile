FROM python:3.10-bullseye as builder

COPY Pipfile* /

RUN set -x && \
pip install -U pip setuptools && \
pip install pipenv && \
pipenv sync --system --bare

FROM python:3.10-slim-bullseye as runner

ARG EXEC_UID="1000"
ARG EXEC_GID="1000"
ARG EXEC_USER="ansible"
ARG EXEC_GROUP="ansible"

COPY --from=builder /usr/local/bin/pipenv* /usr/local/bin/virtualenv* /usr/local/bin/ansible* /usr/local/bin/
COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages

RUN set -x && \
groupadd -g ${EXEC_GID} ${EXEC_GROUP} && \
useradd -m -u ${EXEC_UID} -g ${EXEC_GID} ${EXEC_USER} && \
export DEBIAN_FRONTEND=noninteractive && \
apt-get update -q && \
apt-get upgrade -y -q && \
apt-get autoremove -y && \
apt-get install -y -q --no-install-recommends --auto-remove openssh-client git && \
rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

USER ${EXEC_USER}
