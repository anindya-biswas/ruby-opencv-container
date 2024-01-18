FROM ubuntu:22.04

COPY opencv-lib.tar.gz /

RUN apt-get update && apt-get install -y openssh-server vim git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN tar -xzf /opencv-lib.tar.gz -C /
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bashrc
RUN rbenv install 3.3.0
RUN gem install ruby-opencv
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

CMD ["/bin/bash"]
