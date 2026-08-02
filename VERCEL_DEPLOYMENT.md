# Vercel Deployment Guide

This project is configured for deployment on Vercel using Docker containers.

## Prerequisites

- Vercel account
- GitHub repository connected to Vercel
- Vercel CLI (optional, for local testing)

## Environment Variables

Configure these environment variables in your Vercel project settings:

### Required Variables

- `PORT` - Port for the service (default: `8080`)
- `HEADLESS` - Run browser in headless mode (default: `true`)

### Optional Variables

None currently required for basic functionality.

## Deployment Steps

### 1. Connect Repository to Vercel

1. Go to [vercel.com](https://vercel.com)
2. Click "Add New Project"
3. Import your GitHub repository
4. Vercel will automatically detect the `vercel.json` configuration

### 2. Configure Environment Variables

In your Vercel project settings:

1. Go to Settings → Environment Variables
2. Add the following variables:
   - `PORT`: `8080`
   - `HEADLESS`: `true`
3. Select the environments (Production, Preview, Development)

### 3. Deploy

Vercel will automatically deploy when you push to your repository:

```bash
git add .
git commit -m "Configure for Vercel deployment"
git push
```

Or deploy manually using Vercel CLI:

```bash
vercel --prod
```

## API Endpoints

After deployment, your endpoints will be available at:

- `GET /api/token` - Get Spotify access token
- `GET /api/token?debug=true` - Get debug information
- `GET /api/metadata?type=playlist|track|album|playlistMetadata|trackRecommender` - Get metadata
- `GET /health` - Health check

## Usage Examples

### Get Anonymous Token

```bash
curl https://your-project.vercel.app/api/token
```

### Get Authenticated Token

```bash
curl --cookie "sp_dc=YOUR_SP_DC_COOKIE" https://your-project.vercel.app/api/token
```

### Health Check

```bash
curl https://your-project.vercel.app/health
```

## Important Notes

### Docker-Based Deployment

This project uses Docker-based deployment on Vercel because:
- It requires headless Chrome for token generation
- The Go application needs browser automation capabilities
- Container-based deployment ensures consistent environment

### Build Configuration

The `vercel.json` file configures:
- Docker build using the existing `Dockerfile`
- Route all traffic to the container
- Automatic deployment on git push

### Performance Considerations

- Cold starts may take 10-30 seconds due to browser initialization
- Tokens are cached in memory for faster subsequent requests
- Memory usage stays at 15-20 MB as designed

### Troubleshooting

If deployment fails:

1. Check Vercel build logs for Docker build errors
2. Ensure `Dockerfile` is present and valid
3. Verify environment variables are set correctly
4. Check that the Go version in `go.mod` is compatible

## Local Testing with Vercel CLI

To test locally before deploying:

```bash
# Install Vercel CLI
npm i -g vercel

# Login
vercel login

# Pull environment variables
vercel env pull .env

# Run locally
vercel dev
```

## Monitoring

- Check Vercel Analytics for performance metrics
- Use Vercel Logs for debugging
- Monitor the `/health` endpoint for service status
- Use `/api/token?debug=true` for detailed service information
