FROM python:3.13.1-alpine3.21 as builder

WORKDIR /app

RUN apk add git
RUN pip install --no-cache-dir --prefix=/install callattendant@git+https://github.com/thess/callattendant@v2.0.6

FROM python:3.13.1-alpine3.21

COPY --from=builder /install /usr/local

WORKDIR /app

COPY ./entrypoint.sh /app/entrypoint.sh
COPY ./app.cfg /app/config_template/app.cfg
RUN chmod 755 /app/entrypoint.sh

ENV PYTHONUNBUFFERED=1
ENV CONFIG_DIR=/app/config
EXPOSE 5000
ENTRYPOINT ["/app/entrypoint.sh"]
