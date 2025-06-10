FROM docker.n8n.io/n8nio/n8n:next

USER root

RUN apk add --no-cache ffmpeg curl git

# Клонируем Telegram-ноды как npm-пакет
RUN mkdir -p /home/node/custom-nodes && \
    git clone https://github.com/n8n-io/n8n-nodes-telegram.git /home/node/custom-nodes/n8n-nodes-telegram-custom

# Даем права и подключаем как custom extensions
ENV N8N_CUSTOM_EXTENSIONS="/home/node/custom-nodes/n8n-nodes-telegram-custom"
RUN chown -R node:node /home/node

USER node
