# base.
FROM ubuntu:22.04
LABEL name=proj_tmpl_python description="proj tmpl python."

# args
ARG user=~
ARG uid=1000

# environment.
ENV PYTHONPATH=/app/app:${PYTHONPATH}
ENV PATH=/app/env/python/install/bin:${PATH}
EXPOSE 8082

# resources.
COPY ./env/python /app/env/python
COPY ./app /app/app
COPY ./gunicorn_config.py /app/

# user and work dir.
USER root
RUN useradd --create-home --no-log-init --uid $uid --shell /bin/bash $user && \
    mkdir -p /app/log && \
    chown -R $user:$user /app
USER $user

# dir for volume.
VOLUME /app/log

# launch.
WORKDIR /app/app
CMD ["python3", "-m", "gunicorn", "-c", "/app/gunicorn_config.py", "app:app"]