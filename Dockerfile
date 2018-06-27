FROM ubuntu:18.04
LABEL maintainer="juan@jpgenovese.com"

# Install all known dependencies
RUN apt-get update && apt-get install -y curl patch gawk g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev webfs linkchecker httpie

# Get keys for RVM
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3

# Install RVM
RUN \curl -L https://get.rvm.io | bash -s stable

# Install possible missing requirements for Ruby, Ruby itself, and Bundler
RUN /bin/bash -l -c "rvm requirements && rvm install 2.5.1 && gem install bundler --no-ri --no-rdoc"

ENTRYPOINT ["/bin/bash", "-l", "-c"]
CMD ["/bin/bash", "-l", "-c"]