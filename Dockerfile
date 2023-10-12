FROM ubuntu:12.04

ARG JDK_BIN_URL="https://mirrors.huaweicloud.com/java/jdk/6u45-b06/jdk-6u45-linux-x64.bin"
ARG JDK_PATH=/usr/lib/jvm/jdk1.6.0_45

RUN apt-get -qq update
RUN apt-get -qq install aptitude # Resolve unmet dependencies with aptitude
RUN aptitude -q -y install git gnupg flex bison gperf build-essential zip curl libc6-dev libncurses5-dev:i386 x11proto-core-dev libx11-dev:i386 libreadline6-dev:i386 libgl1-mesa-glx:i386 libgl1-mesa-dev g++-multilib mingw32 tofrodos python-markdown libxml2-utils xsltproc zlib1g-dev:i386 lib32z1-dev lib32ncurses5-dev
RUN ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 /usr/lib/i386-linux-gnu/libGL.so
RUN mkdir /usr/lib/jvm && cd /usr/lib/jvm && curl -o jdk.bin "$JDK_BIN_URL" && chmod +x jdk.bin && ./jdk.bin && rm jdk.bin
ENV PATH="${JDK_PATH}/bin:${PATH}"

# 添加 sudo 
ARG SUDO_BIN_URL=http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/pool/main/s/sudo/sudo_1.8.3p1-1ubuntu3.10_amd64.deb
RUN curl -o sudo_1.8.3p1-1ubuntu3.10_amd64.deb "$SUDO_BIN_URL" \
&& dpkg -i sudo_1.8.3p1-1ubuntu3.10_amd64.deb \
&& rm sudo_1.8.3p1-1ubuntu3.10_amd64.deb

# 添加用户
RUN useradd --create-home --no-log-init --shell /bin/bash developer \
&& adduser developer sudo \
&& echo 'developer:123456' | chpasswd

USER developer
ENV HOME /home/developer
WORKDIR /home/developer

CMD ["/bin/bash"]
