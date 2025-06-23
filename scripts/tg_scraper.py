#!/usr/bin/env python3
# tg_scraper.py
# Основано на Telethon 1.40.               # источник — официальная документация Telethon
import sys, json, asyncio, os, datetime
from telethon import TelegramClient, functions, types

API_ID   = int(os.environ['TG_API_ID'])     # задайте в n8n → Settings → Environment Variables
API_HASH = os.environ['TG_API_HASH']
SESSION  = '/data/tg_session'               # файл-сессия пользователя Telegram

async def main():
    if len(sys.argv) < 4:
        print("[]")
        return
    keyword, niche, region = sys.argv[1:4]

    async with TelegramClient(SESSION, API_ID, API_HASH) as client:
        res = await client(functions.contacts.SearchRequest(
            q=keyword, limit=100,
            offset_date=None, offset_peer=types.InputPeerEmpty(),
            offset_id=0, hash=0))

        leads = []
        for chat in res.chats:
            username = getattr(chat, 'username', None)
            members  = getattr(chat, 'participants_count', 0)
            if username and members >= 100:
                leads.append({
                    "title": chat.title,
                    "username": username,
                    "members": members,
                    "niche": niche,
                    "region": region,
                    "added_at": datetime.datetime.utcnow().isoformat(timespec="seconds")+"Z"
                })

        print(json.dumps(leads, ensure_ascii=False))

if __name__ == "__main__":
    asyncio.run(main())
