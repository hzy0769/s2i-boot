FROM openshift/base-centos7
MAINTAINER Linzhaoming <teleyic@gmail.com>
# HOME in base image is /opt/app-root/src

# Install build tools on top of base image
# Java jdk 8, Maven 3.6
RUN INSTALL_PKGS="tar unzip bc which lsof java-1.8.0-openjdk java-1.8.0-openjdk-devel" && \
    yum install -y --enablerepo=centosplus $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y && \
    mkdir -p /opt/openshift && \
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
      build-date="${BUILD_DATE}"

# COPY  setting.xml
COPY ./contrib/settings.xml $HOME/.m2/

LABEL io.openshift.s2i.scripts-url=image:///usr/local/s2i
COPY ./s2i/bin/ /usr/local/s2i

RUN chown -R 1001:1001 /opt/openshift

RUN chown -R 1001:1001 /opt
RUN chown -R 1001:1001 /etc
RUN chmod -R a+rw /opt
RUN chmod -R a+rw /etc

# This default user is created in the openshift/base-centos7 image
USER 1001

# Set the default port for applications built using this image
EXPOSE 8080

# Set the default CMD for the image
# CMD ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/opt/openshift/app.jar"]
CMD ["usage"]