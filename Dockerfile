FROM docker.n8n.io/n8nio/n8n:next
USER root
RUN apk add --no-cache ffmpeg curl

# Клонируем весь репозиторий n8n
RUN git clone https://github.com/n8n-io/n8n.git /tmp/n8n

# Копируем свежие Telegram-ноды
RUN mkdir -p /home/node/custom-nodes && \
    cp -r /tmp/n8n/packages/nodes-base/nodes/Telegram /home/node/custom-nodes/Telegram

# Даем права и подключаем custom extensions
RUN chown -R node:node /home/node
ENV N8N_CUSTOM_EXTENSIONS="/home/node/custom-nodes"

USER node
