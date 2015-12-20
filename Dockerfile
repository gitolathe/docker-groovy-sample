
# Pull base image
FROM java:8
MAINTAINER Ola Theander <ola.theander@myola.se>

# Pull and unpack Spring CLI.
RUN mkdir /spring-boot
RUN curl \
    --silent \
    --location \
    --retry 3 \
    "http://repo.spring.io/release/org/springframework/boot/spring-boot-cli/1.3.1.RELEASE/spring-boot-cli-1.3.1.RELEASE-bin.tar.gz" \
    | gunzip \
    | tar x -C /spring-boot/

# Setup Environment variables.
ENV SPRING_HOME spring-boot/spring-1.3.1.RELEASE/
ENV PATH ${PATH}:${SPRING_HOME}/bin

# Add the Groovy file.
ADD app.groovy /

# Do an ECHO.
# RUN /bin/bash -c 'echo Hello World 2!'

# Expose port 8080 for access to Groovy app.
EXPOSE 8080

WORKDIR /

# Run the Groovy app
ENTRYPOINT [ "spring", "run", "app.groovy" ]