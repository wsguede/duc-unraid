FROM httpd:2.4.35
MAINTAINER wsguede <wsguede@gmail.com>

# build duc
RUN set -eux; \
  buildDeps=" \
		wget \
    ca-certificates \
    make \
    apt-utils \
	"; \
  apt-get update; \
  apt-get upgrade -y; \
  apt-get install -y --no-install-recommends libcairo2-dev libpango1.0-dev build-essential libtokyocabinet-dev; \
  apt-get install -y --no-install-recommends -V $buildDeps; \
  wget "https://github.com/zevv/duc/releases/download/1.4.4/duc-1.4.4.tar.gz"; \
  tar -xzf "duc-1.4.4.tar.gz"; \
  cd duc-1.4.4; \
  ./configure --disable-ui --disable-x11 && \
  make && \
  make install; \
  apt-get purge -y --auto-remove $buildDeps


COPY ./index.html /usr/local/apache2/htdocs/

COPY duc.cgi /usr/lib/cgi-bin/
RUN chmod +x /usr/lib/cgi-bin/duc.cgi

RUN duc index /data/ && chmod 777 ~/.duc.db

RUN mkdir /data
VOLUME ["/data"]
