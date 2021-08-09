FROM ckcat/aosp-ubuntu12

# 添加 sudo 
ARG SUDO_BIN_URL=http://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/pool/main/s/sudo/sudo_1.8.3p1-1ubuntu3.10_amd64.deb
RUN curl -o sudo_1.8.3p1-1ubuntu3.10_amd64.deb "$SUDO_BIN_URL" && dpkg -i sudo_1.8.3p1-1ubuntu3.10_amd64.deb $$ rm sudo_1.8.3p1-1ubuntu3.10_amd64.deb

RUN 
# 添加用户
RUN useradd --create-home --no-log-init --shell /bin/bash developer \
&& adduser developer sudo \
&& echo 'developer:123456' | chpasswd


USER developer
ENV HOME /home/developer
WORKDIR /home/developer
ENV PATH="${JDK_PATH}/bin:${PATH}"

CMD ["/bin/bash"]

