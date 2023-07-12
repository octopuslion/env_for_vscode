FROM ubuntu:22.04
LABEL name=proj_tmpl description="proj tmpl."

ENV JAVA_HOME=/app/jdk
EXPOSE 8080
WORKDIR /app
COPY ./jdk /app/jdk
COPY ./build /app/bin

RUN useradd --create-home --no-log-init --shell /bin/bash ~
USER ~
CMD ["jdk/bin/java", "-jar", "bin/java_tmpl-0.1.jar"]