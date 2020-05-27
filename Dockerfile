# hzy/s2i-boot
FROM swr.cn-south-1.myhuaweicloud.com/dgdatav/java8-ubuntu:8u212
MAINTAINER hzy <hzy0769@qq.com>
# HOME in base image is /opt/app-root/src

ENV STI_SCRIPTS_URL=image:///usr/libexec/s2i \
    STI_SCRIPTS_PATH=/usr/libexec/s2i \
	HOME=/opt/app-root/src \
	PATH=/opt/app-root/src/bin:/opt/app-root/bin:$PATH


RUN useradd -u 1001 -r -g 0 -d ${HOME} -s /sbin/nologin       -c "Default Application User" default && \
	mkdir -p /opt/app-root && chown -R 1001:0 /opt/app-root

WORKDIR /opt/app-root/src

# Install build tools on top of base image
RUN mkdir -p /opt/openshift && \
    mkdir -p /opt/app-root/source && chmod -R a+rwX /opt/app-root/source && \
    mkdir -p /opt/s2i/destination && chmod -R a+rwX /opt/s2i/destination && \
    mkdir -p /opt/app-root/src && chmod -R a+rwX /opt/app-root/src

ENV MAVEN_VERSION 3.6.3
ADD apache-maven-$MAVEN_VERSION-bin.tar.gz /usr/local/
RUN mv /usr/local/apache-maven-$MAVEN_VERSION /usr/local/maven && \
    ln -sf /usr/local/maven/bin/mvn /usr/local/bin/mvn && \
    mkdir -p $HOME/.m2 && chmod -R a+rwX $HOME/.m2

ENV PATH=/usr/local/s2i:$PATH

ENV BUILDER_VERSION 1.0

ARG BUILD_DATE

LABEL io.k8s.description="s2i-boot: Building SpringBoot applications with maven" \
      io.k8s.display-name="sti-boot builder 1.0" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,maven-3,java,microservices,springboot" \
      vendor="Linzhaoming" \
      name="S2I Boot Builder" \
      build-date="${BUILD_DATE}" \
	  io.openshift.s2i.scripts-url=image:///usr/libexec/s2i \
	  io.s2i.scripts-url=image:///usr/libexec/s2i

# COPY  setting.xml
COPY ./contrib/settings.xml $HOME/.m2/

LABEL io.openshift.s2i.scripts-url=image:///usr/local/s2i
COPY ./s2i/bin/ /usr/local/s2i

RUN chown -R 1001:1001 /opt/openshift

# This default user is created in the openshift/base-centos7 image
USER 1001

# Set the default port for applications built using this image
EXPOSE 8080

# Set the default CMD for the image
# CMD ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/opt/openshift/app.jar"]
CMD ["usage"]
