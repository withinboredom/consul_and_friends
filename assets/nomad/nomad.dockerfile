FROM golang:latest
RUN mkdir -p $GOPATH/src/github.com/hashicorp \
    && cd $GOPATH/src/github.com/hashicorp \
    && git clone https://github.com/hashicorp/nomad.git \
    && cd nomad \
    && make bootstrap \
    && make dev \
    && cp bin/nomad /bin/nomad \
    && cd .. \
    && rm -rf nomad

RUN curl https://get.docker.com/ | sh

COPY assets/nomad/nomad.sh /start.sh
COPY assets/nomad/nomad_client.json /nomad_client.json
COPY assets/nomad/nomad.json /nomad.json
