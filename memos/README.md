# Memos EdgeApp

A privacy-first, lightweight note-taking service. Easily capture and share your great thoughts.

## Features

- Privacy-first and lightweight
- Self-hosted solution
- Simple and intuitive interface
- Markdown support
- Tag-based organization

## Configuration

The app runs on port 5230 internally and is accessible via the EdgeBox reverse proxy at `memos.hostname.local`.

## Data Persistence

All memos data is stored in `./appdata/memos-ws/` which maps to `/var/opt/memos` inside the container.

## Environment Variables

- `MEMOS_MODE`: Set to "prod" for production mode
- `MEMOS_PORT`: Internal port (5230)

## Access

After installation, access Memos at: `http://memos.hostname.local`

For internet access, configure the `INTERNET_URL` in `myedgeapp.env`.