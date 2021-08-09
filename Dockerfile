FROM ckcat/aosp-ubuntu12

# 添加用户
RUN useradd --create-home --no-log-init --shell /bin/bash developer \
&& adduser developer sudo \
&& echo 'developer:123456' | chpasswd


USER developer
ENV HOME /home/developer
WORKDIR /home/developer

CMD ["/bin/bash"]

