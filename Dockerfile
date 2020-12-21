FROM ubuntu:18.04
LABEL maintainer="sunil@bitcoinsfacil.com"

ARG MYCE_UID=51472
ARG MYCE_VERSION=3.0.3

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt update -y && apt upgrade -y

RUN apt-get -y install curl
RUN apt-get -y install wget

RUN wget https://github.com/myceworld/myce/releases/download/v${MYCE_VERSION}.0/myce-${MYCE_VERSION}-x86_64-linux-gnu.tar.gz
RUN tar xvzf myce-${MYCE_VERSION}-x86_64-linux-gnu.tar.gz
RUN ls
RUN cp myce-${MYCE_VERSION}/bin/myced /usr/local/bin/myced
RUN cp myce-${MYCE_VERSION}/bin/myce-cli /usr/local/bin/myce-cli

RUN useradd --uid ${MYCE_UID} --create-home --home-dir /myce myce && \
    mkdir -m 0750 /myce/.myce && \
    echo "rpcuser=username \nrpcpassword=password \nserver=1 \nrpcport=4515 \nrpcallowip=0.0.0.0/0 \ntxindex=1 \ndbcache=2048 \nstaking=0" > "/myce/.myce/myce.conf" && \
    chown -R myce:myce /myce

USER myce
# \nport=${MYCE_UID}
#EXPOSE ${MYCE_UID} 8332 8333 18332 18333

VOLUME ["/myce/.myce"]
WORKDIR /myce

ENTRYPOINT ["/usr/local/bin/myced"]
CMD [ "-printtoconsole" ]
