[![Build Status](https://travis-ci.org/linzhaoming/s2i-boot.svg?branch=master)](https://travis-ci.org/linzhaoming/s2i-boot)
[![Docker Pulls](https://img.shields.io/docker/pulls/linzhaoming/s2i-boot.svg)](https://hub.docker.com/r/linzhaoming/s2i-boot/)
[![Docker Stars](https://img.shields.io/docker/stars/linzhaoming/s2i-boot.svg)](https://hub.docker.com/r/linzhaoming/s2i-boot/)
[![](https://badge.imagelayers.io/linzhaoming/s2i-boot:latest.svg)](https://imagelayers.io/?images=linzhaoming/s2i-boot:latest)


# s2i-boot: OpenShift S2I Builder for SpringBoot

The image is available directly from [Docker Hub](https://hub.docker.com/r/linzhaoming/s2i-boot/)

**s2i-boot**(Source-to-Image Builder) let's you create projects targeting SpringBoot Appliction, build with Java OpenJDK 8 and maven

**Tested** at [Openshift](https://docs.openshift.org/) `3.6.x`

[QuickStart](docs/QuickStart.md) 

## BUILD ENV Options

* *APP_SUFFIX*: Jar file suffix to use to locate the generated artifact to use (e.g. xxxxx${APP_SUFFIX}.jar)
* *BUILDER_ARGS*: Allows you to specify options to pass to maven
* *MAVEN_MIRROR_URL*: Maven mirror url

## RUN ENV Options

* *APP_OPTIONS*: Options to pass to *java -jar app.jar ${APP_OPTIONS}*

## Defaults
If you do not specify any BUILDER_ARGS, by default the s2i image will use the following:

    ```
    MAVEN_ARGS="package -DskipTests"
    ```

## Usage

* First load all the needed resources in a project.

    ```
    oc create -f https://raw.githubusercontent.com/linzhaoming/s2i-boot/master/openshift/s2i-boot-imagestream.yml
    ```

* Importing the template example

    ```
    $ oc create -f https://raw.githubusercontent.com/linzhaoming/s2i-boot/master/openshift/example-s2i-boot.yml
    ```

* Once the builder s2i-boot has been registered, you can create an app with:

** Instant app already provided as template
** Using the s2i-boot builder image using a regular Git repository

## Samples
There is a lot of example SpringBoot applications [here](https://github.com/spring-projects/spring-boot/tree/master/spring-boot-samples)