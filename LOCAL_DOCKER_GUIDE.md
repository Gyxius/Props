# Local Docker Development Guide

Your code works **both locally and on Render**! 🎉

## How It Works

### **Local (Docker Compose)**
- Backend uses **SQLite** database (`./backend/social.db`)
- Backend runs on `http://localhost:8000`
- Frontend runs on `http://localhost:3000`
- Frontend connects to backend via `REACT_APP_API_URL=http://localhost:8000`

### **Production (Render + Netlify)**
- Backend uses **PostgreSQL** database (persistent, managed by Render)
- Backend runs on `https://fast-api-backend-qlyb.onrender.com`
- Frontend runs on `https://lemi-cite.netlify.app`
- Frontend connects to backend via `REACT_APP_API_URL=https://fast-api-backend-qlyb.onrender.com`

## Quick Start

### 1. **Start Local Development**
```bash
# From the Props directory
docker compose up
```

This will:
- Build both backend and frontend containers
- Start backend on http://localhost:8000
- Start frontend on http://localhost:3000
- Create a SQLite database at `./backend/social.db`

### 2. **Access Your App**
- **Frontend**: Open http://localhost:3000 in your browser
- **Backend API**: http://localhost:8000/docs (FastAPI Swagger UI)
- **Health Check**: http://localhost:8000/users

### 3. **View Logs**
```bash
# All services
docker compose logs -f

# Just backend
docker compose logs -f backend

# Just frontend
docker compose logs -f frontend
```

### 4. **Stop Everything**
```bash
# Stop but keep containers
docker compose stop

# Stop and remove containers (database persists)
docker compose down

# Stop, remove containers AND volumes (deletes database)
docker compose down -v
```

### 5. **Rebuild After Code Changes**
```bash
# Rebuild and restart
docker compose up --build

# Force rebuild without cache
docker compose build --no-cache
docker compose up
```

## Database Management

### **Local SQLite**
- Location: `./backend/social.db`
- Persisted on your host machine (survives container restarts)
- Access: `sqlite3 ./backend/social.db`

### **Reset Local Database**
```bash
# Stop containers
docker compose down

# Delete database
rm ./backend/social.db

# Restart (will create fresh database)
docker compose up
```

## Troubleshooting

### **Port Already in Use**
If port 8000 or 3000 is already in use:
```bash
# Find what's using the port
lsof -i :8000
lsof -i :3000

# Kill the process
kill -9 <PID>
```

Or change the port in `docker-compose.yml`:
```yaml
ports:
  - "8001:8000"  # Host:Container
```

### **Frontend Can't Connect to Backend**
Make sure:
1. Backend container is running: `docker ps | grep lemi-backend`
2. Backend is healthy: Visit http://localhost:8000/users
3. Check frontend logs: `docker compose logs frontend`

### **Database Changes Not Persisting**
Make sure you're not using `docker compose down -v` (the `-v` flag removes volumes).

### **Code Changes Not Reflecting**
- **Backend**: Should auto-reload (uvicorn --reload)
- **Frontend**: Should auto-reload (Create React App hot reload)
- If not working, rebuild: `docker compose up --build`

## Development Workflow

### **Recommended: Run Locally Without Docker**

For faster development, you might prefer running without Docker:

#### Backend:
```bash
cd backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
uvicorn main:app --reload --port 8000
```

#### Frontend:
```bash
cd web-frontend
npm install
npm start
```

This gives you:
- Faster startup times
- Direct file access
- Better IDE integration
- Same SQLite database behavior

## Environment Variable Summary

| Environment | DATABASE_URL | Backend URL | Database Type |
|-------------|--------------|-------------|---------------|
| **Local Docker** | (not set) | http://localhost:8000 | SQLite |
| **Local Native** | (not set) | http://localhost:8000 | SQLite |
| **Render Production** | (auto-injected) | https://fast-api-backend-qlyb.onrender.com | PostgreSQL |

## Key Files

- `docker-compose.yml` - Orchestrates both services
- `backend/Dockerfile` - Backend container config
- `web-frontend/Dockerfile` - Frontend container config
- `backend/main.py` - Auto-detects database based on DATABASE_URL
- `web-frontend/src/api.js` - Uses REACT_APP_API_URL environment variable

## Summary

✅ **Your code is dual-mode:**
- **Local**: SQLite (easy, no setup)
- **Production**: PostgreSQL (persistent, managed)

✅ **To develop locally:**
```bash
docker compose up
# Visit http://localhost:3000
```

✅ **To deploy to production:**
```bash
git push origin main
# Render and Netlify auto-deploy
```

Both modes work independently - changes to one don't affect the other! 🚀
