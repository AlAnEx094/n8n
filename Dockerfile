FROM docker.n8n.io/n8nio/n8n:next

USER root

RUN apk add --no-cache ffmpeg curl git

# Клонируем репозиторий n8n
RUN git clone https://github.com/n8n-io/n8n.git /tmp/n8n

# Копируем Telegram-ноды и создаем структуру
RUN mkdir -p /home/node/custom-nodes/n8n-nodes-telegram-custom/nodes/Telegram/credentials && \
    cp -r /tmp/n8n/packages/nodes-base/nodes/Telegram/* /home/node/custom-nodes/n8n-nodes-telegram-custom/nodes/Telegram/ && \
    cp /tmp/n8n/packages/nodes-base/credentials/TelegramApi.credentials.ts /home/node/custom-nodes/n8n-nodes-telegram-custom/nodes/Telegram/credentials/

# Создаем package.json
RUN echo '{ \
  "name": "n8n-nodes-telegram-custom", \
  "version": "1.0.0", \
  "n8n": { \
    "nodes": [ \
      "nodes/Telegram/Telegram.node.ts", \
      "nodes/Telegram/TelegramTrigger.node.ts" \
    ], \
    "credentials": [ \
      "nodes/Telegram/credentials/TelegramApi.credentials.ts" \
    ] \
  } \
}' > /home/node/custom-nodes/n8n-nodes-telegram-custom/package.json

ENV N8N_CUSTOM_EXTENSIONS="/home/node/custom-nodes/n8n-nodes-telegram-custom"

RUN chown -R node:node /home/node

USER node
