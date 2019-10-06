FROM ubuntu:latest as builder

RUN apt-get update
RUN apt-get install curl -y
RUN curl -L -o /tmp/go.sh https://install.direct/go.sh
RUN chmod +x /tmp/go.sh
RUN /tmp/go.sh

FROM alpine:latest


RUN sudo -i && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    cd /etc/v2ray && \
    echo -e "$CONFIG_JSON" > config.json && \
    systemctl restart v2ray.service

ENV PATH /usr/bin/v2ray:$PATH

CMD ["v2ray", "-config=/etc/v2ray/config.json"]
