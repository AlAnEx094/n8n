FROM docker.n8n.io/n8nio/n8n:next
USER root
RUN apk add --no-cache ffmpeg curl
RUN apk add --no-cache python3 py3-pip
RUN pip3 install --no-cache-dir telethon==1.40
COPY scripts/tg_scraper.py /data/scripts/tg_scraper.py
RUN chmod +x /data/scripts/tg_scraper.py
RUN chown -R node:node /home/node/.n8n
USER node
