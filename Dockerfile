FROM ubuntu:12.04

ARG JDK_BIN_URL="https://mirrors.huaweicloud.com/java/jdk/6u45-b06/jdk-6u45-linux-x64.bin"
ARG JDK_PATH=/usr/lib/jvm/jdk1.6.0_45

# 配置编译环境
RUN sed -i.bak -r 's/(archive|security).ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list \
    && apt-get -qq update && apt-get -qq install aptitude \
    && aptitude -q -y install sudo git gnupg flex bison gperf build-essential zip curl libc6-dev libncurses5-dev:i386 \
    x11proto-core-dev libx11-dev:i386 libreadline6-dev:i386 libgl1-mesa-glx:i386 libgl1-mesa-dev g++-multilib mingw32 \
    tofrodos python-markdown libxml2-utils xsltproc zlib1g-dev:i386 lib32z1-dev lib32ncurses5-dev \
    && ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 /usr/lib/i386-linux-gnu/libGL.so \
    && mkdir /usr/lib/jvm && cd /usr/lib/jvm && curl -o jdk.bin "$JDK_BIN_URL" && chmod +x jdk.bin && ./jdk.bin && rm jdk.bin \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && useradd --create-home --no-log-init --shell /bin/bash local \
    && echo 'local:toor' | chpasswd \
    && adduser local sudo

# 切换到新用户并设置环境变量和工作目录
USER local
ENV PATH="${JDK_PATH}/bin:${PATH}" HOME=/home/local
WORKDIR /home/local

# 设置默认的 shell
CMD ["/bin/bash"]
