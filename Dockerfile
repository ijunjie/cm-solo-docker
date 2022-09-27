FROM ubuntu:20.04

WORKDIR /app

COPY ./bin ./bin
COPY ./lib/libwasmer.so /usr/lib/
COPY ./lib/wxdec /usr/bin/
COPY ./config ./config

RUN rm /bin/sh && ln -s /bin/bash /bin/sh && \
    sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
    apt-get update && apt-get install -y p7zip-full && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && \
    echo "Asia/Shanghai" > /etc/timezone && \
    ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    dpkg-reconfigure tzdata -f noninteractive && \
    chmod 755 ./bin/* && \
    chmod 755 /usr/bin/wxdec && \
    #sed -i 's#enable_dockervm: true#enable_dockervm: false#g' ./config/chainmaker.yml && \
    #sed -i '1,/log_in_console: false/{s/log_in_console: false/log_in_console: true/}' ./config/log.yml && \
    apt-get clean -y && \
    rm -rf /var/cache/debconf/* /var/lib/apt/lists/* /var/log/* /var/tmp/* && \
    rm -rf /tmp/*

WORKDIR /app/bin

ENTRYPOINT ["./chainmaker", "start", "-c", "../config/chainmaker.yml"]
