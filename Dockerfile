FROM --platform=linux/amd64 ubuntu:22.04

COPY opencv-lib.tar.gz /

RUN echo "Step 1: Installing Core Libraries..."
RUN apt-get update && apt-get install -y git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev ruby-dev
RUN echo "Step 2: Installing opencv libraries..."
RUN tar -xzf /opencv-lib.tar.gz -C /
RUN echo "Step 2: Installing rbenv..."
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bashrc
RUN /root/.rbenv/bin/rbenv install 2.7.8
RUN /root/.rbenv/bin/rbenv global 2.7.8
RUN gem install ruby-opencv

CMD ["/bin/bash"]