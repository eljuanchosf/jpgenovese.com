FROM debian:stretch
LABEL maintainer="juan@jpgenovese.com"

RUN apt-get update \
&&  apt-get upgrade -y --force-yes \
&&  apt-get install -y --force-yes \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    wget \
    curl \
    git \
    build-essential \
    dtach \
    libffi-dev \
    libxslt1-dev \
    webfs \
    httpie \
    linkchecker \
    sshpass \
    wkhtmltopdf \
&&  apt-get clean \
&&  rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# node.js LTS install
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y nodejs \
    && npm -g up

# yarn install
RUN curl -o- -L https://yarnpkg.com/install.sh | bash

RUN git clone git://github.com/rbenv/rbenv.git /usr/local/rbenv \
&&  git clone git://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/ruby-build \
&&  git clone git://github.com/jf/rbenv-gemset.git /usr/local/rbenv/plugins/rbenv-gemset \
&&  /usr/local/rbenv/plugins/ruby-build/install.sh
ENV PATH /usr/local/rbenv/bin:$PATH
ENV RBENV_ROOT /usr/local/rbenv

RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh \
&&  echo 'export PATH=/usr/local/rbenv/bin:$PATH' >> /etc/profile.d/rbenv.sh \
&&  echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /root/.bashrc \
&&  echo 'export PATH=/usr/local/rbenv/bin:$PATH' >> /root/.bashrc \
&&  echo 'eval "$(rbenv init -)"' >> /root/.bashrc

ENV CONFIGURE_OPTS --disable-install-doc
ENV PATH /usr/local/rbenv/bin:/usr/local/rbenv/shims:$PATH

ENV RBENV_VERSION 2.5.1

RUN eval "$(rbenv init -)"; rbenv install $RBENV_VERSION \
&&  eval "$(rbenv init -)"; rbenv global $RBENV_VERSION \
&&  eval "$(rbenv init -)"; gem update --system \
&&  eval "$(rbenv init -)"; gem install bundler -f

RUN eval "$(rbenv init -)"; gem install jekyll --version=3.8.3 --no-rdoc --no-ri \
&&  eval "$(rbenv init -)"; gem install jekyll-feed --version=0.10.0 --no-rdoc --no-ri \
&&  eval "$(rbenv init -)"; gem install jekyll-assets --version=2.2.8 --no-rdoc --no-ri \
&&  eval "$(rbenv init -)"; gem install foreman --version=0.64.0 --no-rdoc --no-ri \
&&  rm -rf /tmp/*

RUN npm install npm -g \
    && npm install hackmyresume -g

EXPOSE 4000 80