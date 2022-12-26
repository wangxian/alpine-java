# alpine-java
This creates a Docker container running Java on Alpine Linux.

docker build -t wangxian/alpine-java:jre11-openj9 . \
docker run -it --rm wangxian/alpine-java:jre11-openj9 bash \
docker push wangxian/alpine-java:jre11-openj9
