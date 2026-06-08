FROM python:slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone --depth 1 https://github.com/halfaider/gd-poller.git /app/gd-poller \
    && pip install --no-cache-dir -e /app/gd-poller \
    && git clone --depth 1 https://github.com/halfaider/flaskfarmaider-bot.git /app/flaskfarmaider-bot \
    && pip install --no-cache-dir -e /app/flaskfarmaider-bot

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]