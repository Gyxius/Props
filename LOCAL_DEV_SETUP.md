# Local Development Setup

## Environment Configuration

This project uses different API endpoints for local development vs. production:

### Files:
- **`.env`** - Production/default settings (committed to git)
  - `REACT_APP_API_URL=https://fast-api-backend-qlyb.onrender.com`
  
- **`.env.local`** - Local development settings (gitignored, NOT committed)
  - `REACT_APP_API_URL=http://localhost:8001`

### How it works:
- `.env.local` automatically overrides `.env` when running locally
- Deployed versions (Netlify/Render) use `.env` by default
- `.env.local` is in `.gitignore` so your local settings don't affect production

## Running Locally

### 1. Start the Backend (Terminal 1)
```bash
cd backend
python3 -m uvicorn main:app --host 0.0.0.0 --port 8001 --reload
```
Backend will be available at: `http://localhost:8001`

### 2. Start the Frontend (Terminal 2)
```bash
cd web-frontend
npm start
```
Frontend will be available at: `http://localhost:3000`

The frontend will automatically connect to your local backend on port 8001.

## Testing the Follow System

### Automated Tests
```bash
cd backend
python3 test_follow_system.py
```

### Manual API Testing
```bash
# Add a follow
curl -X POST http://localhost:8001/api/follows \
  -H "Content-Type: application/json" \
  -d '{"user1": "alice", "user2": "bob"}'

# Check follows
curl http://localhost:8001/api/follows/alice

# Check followers
curl http://localhost:8001/api/followers/bob

# Unfollow
curl -X DELETE http://localhost:8001/api/follows \
  -H "Content-Type: application/json" \
  -d '{"user1": "alice", "user2": "bob"}'
```

## Deployment

When deploying:
- **Netlify** (frontend) automatically uses `.env` 
- **Render** (backend) uses environment variables set in Render dashboard
- No changes needed - it just works! ✅
