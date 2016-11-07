FROM ubuntu:14.04

RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# base...
RUN apt-get update
RUN apt-get -y upgrade && apt-get clean
RUN apt-get install -y \
  build-essential \
  git \
  curl \
  wget \
  tar \
  libssl-dev \
  libreadline-dev \
  && apt-get clean

# global - ruby dependencies...
RUN apt-get install -y libxslt-dev libxml2-dev && apt-get clean

# global - ruby install...
ADD ./bin/install-ruby /tmp/install-ruby
RUN chmod a+x /tmp/install-ruby
RUN cd /tmp && ./install-ruby && rm install-ruby

# install - qa runner
ADD ./bin/install-qa /tmp/install-qa
RUN chmod a+x /tmp/install-qa
RUN cd /tmp && ./install-qa && rm install-qa
