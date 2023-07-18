# base.
FROM ubuntu:22.04
LABEL name=proj_tmpl description="proj tmpl."

# args
ARG user=~
ARG uid=1000

# environment.
ENV JAVA_HOME=/app/jdk
EXPOSE 8080

# resources.
COPY ./jdk /app/jdk
COPY ./build /app/bin

# user and work dir.
USER root
RUN useradd --create-home --no-log-init --uid $uid --shell /bin/bash $user && \
    mkdir -p /app/log && \
    chown -R $user:$user /app
USER $user

# dir for volume.
VOLUME /app/log

# launch.
WORKDIR /app
CMD ["jdk/bin/java", "-jar", "bin/demo_java-0.1.jar"]