FROM adoptopenjdk/openjdk11-openj9:x86_64-alpine-jdk-11.0.11_9_openj9-0.26.0
MAINTAINER WangXian <xian366@126.com>

WORKDIR /app

# install packages
RUN apk add --update curl openssl wget bash maven \
    && apk add tzdata && cp /usr/share/zoneinfo/PRC /etc/localtime && echo "PRC" > /etc/timezone && apk del tzdata \
    && rm -rfv /var/cache/apk/* \
    && java -version

# copy source to image
ADD . .
RUN rm -rf /app/.git /app/.dockerignore && mv /app/docker/startup.sh /app

EXPOSE 8080
CMD ["/bin/sh", "/app/startup.sh"]