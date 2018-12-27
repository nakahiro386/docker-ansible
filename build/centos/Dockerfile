FROM centos:7

ARG EXEC_UID="1000"
ARG EXEC_GID="1000"
ARG EXEC_USER="ansible"
ARG EXEC_GROUP="ansible"

ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "-g", "--"]

RUN set -x && \
/sbin/groupadd -g ${EXEC_GID} ${EXEC_GROUP} && \
/sbin/useradd -m -u ${EXEC_UID} -g ${EXEC_GID} ${EXEC_USER} && \
yum -q -y upgrade && \
yum -q -y install epel-release && \
yum -q -y install git python2-pip ansible && \
yum -q -y clean all && \
rm -rf /var/cache/yum
# pip install --no-cache-dir foo bar baz

USER ${EXEC_USER}
