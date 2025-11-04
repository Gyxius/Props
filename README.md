# Lemi - Social Event Platform

A full-stack application for managing and joining social events with admin assignment and user acceptance flows.

## 🚀 Quick Start with Docker

### Prerequisites
- Docker Desktop installed on your machine

### Running the Application

1. **Start both services (from the project directory):**
   ```bash
   cd /Users/mitsoufortunat/Desktop/Props
   docker compose up
   ```

2. **Access the applications:**
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:8000
   - API Documentation: http://localhost:8000/docs

3. **Stop the services:**
   - Press `Ctrl+C` in the terminal, or run:
   ```bash
   docker compose down
   ```

### Development Commands

**Start in background (detached mode):**
```bash
docker compose up -d
```

**View logs:**
```bash
docker compose logs -f
```

**View logs for a specific service:**
```bash
docker compose logs -f backend
docker compose logs -f frontend
```

**Restart a specific service:**
```bash
docker compose restart backend
docker compose restart frontend
```

**Rebuild after dependency changes (package.json or requirements.txt):**
```bash
docker compose up --build
```

**Stop and remove containers:**
```bash
docker compose down
```

**Stop and remove containers with volumes:**
```bash
docker compose down -v
```

## 🛠️ Manual Setup (Without Docker)

### Backend Setup

1. Navigate to backend directory:
   ```bash
   cd backend
   ```

2. Create and activate virtual environment:
   ```bash
   python3 -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Run the server:
   ```bash
   uvicorn main:app --reload --host 0.0.0.0 --port 8000
   ```

### Frontend Setup

1. Navigate to frontend directory:
   ```bash
   cd web-frontend
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Start the development server:
   ```bash
   npm start
   ```

## 📁 Project Structure

```
Lemi/
├── backend/              # FastAPI backend
│   ├── main.py          # API endpoints
│   ├── requirements.txt # Python dependencies
│   └── Dockerfile       # Backend Docker config
├── web-frontend/        # React frontend
│   ├── src/            # Source files
│   ├── package.json    # Node dependencies
│   └── Dockerfile      # Frontend Docker config
└── docker-compose.yml  # Docker orchestration
```

## 🎯 Features

- **User Authentication**: Simple username-based login
- **Event Management**: Create public and private events
- **Admin Dashboard**: Assign events to users with match analysis
- **User Acceptance Flow**: Users can accept or decline suggested events
- **Public Events**: Browse and join public events directly
- **Match Analysis**: See how well events match user preferences
- **Real-time Sync**: Auto-sync across tabs using localStorage

## 🔧 Configuration

### Backend API URL

The frontend connects to the backend via environment variable. Update in `docker-compose.yml`:
```yaml
environment:
  - REACT_APP_API_URL=http://localhost:8000
```

Or for manual setup, update the API URLs in:
- `web-frontend/src/Login.js`
- `web-frontend/src/SocialRoulette.js`

## 🐛 Troubleshooting

**Port already in use:**
```bash
# Find and kill process using port 8000
lsof -ti:8000 | xargs kill -9

# Find and kill process using port 3000
lsof -ti:3000 | xargs kill -9
```

**Docker build issues:**
```bash
# Clean rebuild
docker-compose down
docker-compose build --no-cache
docker-compose up
```

**Frontend not connecting to backend:**
- Check backend is running: http://localhost:8000/docs
- Verify API URL in frontend configuration
- Check browser console for CORS errors

## 📝 License

Private project - All rights reserved
