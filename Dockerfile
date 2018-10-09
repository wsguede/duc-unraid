FROM httpd:2.4.35-alpine
MAINTAINER wsguede <wsguede@gmail.com>

RUN apt-get update
RUN apk-get install duc -y

COPY ./index.html /usr/local/apache2/htdocs/

COPY duc.cgi /usr/lib/cgi-bin/
RUN chmod +x /usr/lib/cgi-bin/duc.cgi

RUN duc index /data/ && chmod 777 ~/.duc.db

RUN mkdir /data
VOLUME ["/data"]