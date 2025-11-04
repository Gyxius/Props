#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${RED}🛑 Stopping Lemi Application...${NC}\n"

# Stop backend
if [ -f .backend.pid ]; then
    BACKEND_PID=$(cat .backend.pid)
    echo "Stopping Backend (PID: $BACKEND_PID)..."
    kill $BACKEND_PID 2>/dev/null || echo "Backend already stopped"
    rm .backend.pid
fi

# Stop frontend
if [ -f .frontend.pid ]; then
    FRONTEND_PID=$(cat .frontend.pid)
    echo "Stopping Frontend (PID: $FRONTEND_PID)..."
    kill $FRONTEND_PID 2>/dev/null || echo "Frontend already stopped"
    rm .frontend.pid
fi

# Also kill any remaining node/uvicorn processes
pkill -f "uvicorn main:app" 2>/dev/null
pkill -f "react-scripts start" 2>/dev/null

echo -e "\n${GREEN}✅ All services stopped${NC}"
