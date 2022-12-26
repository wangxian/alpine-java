FROM adoptopenjdk/openjdk11-openj9:x86_64-alpine-jdk-11.0.11_9_openj9-0.26.0
MAINTAINER WangXian <xian366@126.com>

WORKDIR /app

# install packages
RUN apk add --update curl openssl bash \
    && apk add tzdata && cp /usr/share/zoneinfo/PRC /etc/localtime && echo "PRC" > /etc/timezone && apk del tzdata \
    && curl -o /tmp/apache-maven-3.8.6-bin.zip https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.zip \
    && unzip /tmp/apache-maven-3.8.6-bin.zip -d /usr/local/ \
    && ln -sfv /usr/local/apache-maven-3.8.6/bin/mvn /usr/local/bin \
    && rm -rfv /var/cache/apk/* /tmp/* \
    && java -version && mvn -version

# copy source to image
ADD . .
RUN rm -rf /app/.git /app/.dockerignore && mv /app/docker/startup.sh /app

EXPOSE 8080
CMD ["/bin/sh", "/app/startup.sh"]