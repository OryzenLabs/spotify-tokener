# Deployment Guide

This project requires headless Chrome for Spotify token generation, so it needs a platform that supports Docker containers with browser capabilities.

## Recommended Platforms

### 1. Railway (Easiest)
- Supports Docker containers
- Free tier available
- Auto-deploy from GitHub

**Deployment:**
1. Go to [railway.app](https://railway.app)
2. Click "New Project" → "Deploy from GitHub repo"
3. Select this repository
4. Railway will detect `railway.json` and `Dockerfile`
5. Set environment variables:
   - `PORT`: `8080`
   - `HEADLESS`: `true`
6. Deploy!

### 2. Render
- Free tier available
- Docker support

**Deployment:**
1. Go to [render.com](https://render.com)
2. Click "New" → "Web Service"
3. Connect GitHub repository
4. Select "Docker" as runtime
5. Use `render.yaml` configuration
6. Set environment variables

### 3. Fly.io
- Global deployment
- Docker support

**Deployment:**
```bash
# Install Fly CLI
curl -L https://fly.io/install.sh | sh

# Login
fly auth login

# Deploy
fly launch
```

## Environment Variables

All platforms require:
- `PORT`: `8080` (required)
- `HEADLESS`: `true` (required)

## API Endpoints

After deployment:
- `GET /api/token` - Get Spotify access token
- `GET /api/token?debug=true` - Debug information
- `GET /api/metadata?type=...` - Get metadata
- `GET /health` - Health check

## Why Not Vercel?

Vercel doesn't support Docker containers with headless Chrome. This application needs:
- Full container environment
- Headless browser for token generation
- Long-running server (not serverless)

## Usage Examples

### Get Anonymous Token
```bash
curl https://your-app.railway.app/api/token
```

### Get Authenticated Token
```bash
curl --cookie "sp_dc=YOUR_COOKIE" https://your-app.railway.app/api/token
```

### Health Check
```bash
curl https://your-app.railway.app/health
```
