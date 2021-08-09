FROM ckcat/aosp-ubuntu12

# 添加用户
RUN useradd --create-home --no-log-init --shell /bin/bash developer \
&& echo 'developer:123456' | chpasswd
&& echo "developer  ALL=(ALL)       ALL" >> /etc/sudoers


USER developer
ENV HOME /home/developer
WORKDIR /home/developer
ENV PATH="${JDK_PATH}/bin:${PATH}"

CMD ["/bin/bash"]

