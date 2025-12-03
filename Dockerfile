FROM python:3.14.1-alpine3.21 AS builder

WORKDIR /app

RUN apk add --no-cache \
    git \
    gcc \
    musl-dev \
    libxml2-dev \
    libxslt-dev \
    py3-lxml \
    python3-dev

RUN pip install --no-cache-dir --prefix=/install paho-mqtt
RUN pip install --no-cache-dir --prefix=/install callattendant@git+https://github.com/thess/callattendant@v2.3.0

FROM python:3.14.1-alpine3.21

COPY --from=builder /install /usr/local

WORKDIR /app

COPY ./entrypoint.sh /app/entrypoint.sh
COPY ./app.cfg /app/config_template/app.cfg
RUN chmod 755 /app/entrypoint.sh

ENV PYTHONUNBUFFERED=1
ENV CONFIG_DIR=/app/config
EXPOSE 5000
ENTRYPOINT ["/app/entrypoint.sh"]
