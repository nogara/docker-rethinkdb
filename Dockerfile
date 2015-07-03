FROM docker.io/ubuntu:vivid
MAINTAINER Edgard Castro <castro@edgard.org>

# Keep image updated
ENV REFRESHED_AT 2015-07-28-05-16Z

# Add repositories and update base
RUN echo "deb http://archive.ubuntu.com/ubuntu/ vivid main restricted universe multiverse" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu/ vivid-updates main restricted universe multiverse" >> /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu/ vivid-backports main restricted universe multiverse" >> /etc/apt/sources.list \
  && echo "deb http://security.ubuntu.com/ubuntu vivid-security main restricted universe multiverse" >> /etc/apt/sources.list \
  && apt-get update -q \
  && DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -qy

# Install software
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy --no-install-recommends curl ca-certificates \
  && echo "deb http://download.rethinkdb.com/apt vivid main" > /etc/apt/sources.list.d/rethinkdb.list \
  && curl -Ls http://download.rethinkdb.com/apt/pubkey.gpg | apt-key add - \
  && apt-get update -q \
  && DEBIAN_FRONTEND=noninteractive apt-get install -qy --no-install-recommends rethinkdb \
  && apt-get clean \
  && rm -rf /var/lib/apt /tmp/* /var/tmp/*

# Start command
CMD ["rethinkdb", "--bind", "all", "-d", "/data"]
