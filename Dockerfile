FROM ubuntu:16.04
MAINTAINER maiha@wota.jp

# Install packages
RUN \
  # use fast mirror for Japan
  sed -i "s%http://archive.ubuntu.com/ubuntu/%http://ftp.riken.go.jp/Linux/ubuntu/%g" /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y git openssh-client ansible curl build-essential && \
  # need following libs to compile crystal with "-lz" "-lssl"
  apt-get install -y zlib1g-dev libssl-dev && \
  rm -rf /var/lib/apt/lists/*

# Install crystal via crenv
RUN \
  curl -L https://raw.github.com/pine/crenv/master/install.sh | bash && \
  echo 'export PATH="$HOME/.crenv/bin:$PATH"' > /etc/profile.d/crenv.sh && \
  echo 'eval "$(crenv init -)"' >> /etc/profile.d/crenv.sh

RUN \
  bash -l -c 'crenv install 0.20.5' && \
  bash -l -c 'crenv global 0.20.5'

CMD ["bash", "-l"]
