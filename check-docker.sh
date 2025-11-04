#!/bin/bash
# Quick Docker Compose Test Script

echo "🔍 Checking Docker setup..."
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker Desktop."
    exit 1
fi

echo "✅ Docker is running"
echo ""

# Check if files exist
echo "📁 Checking required files..."
files=(
    "docker-compose.yml"
    "backend/Dockerfile"
    "backend/main.py"
    "backend/requirements.txt"
    "web-frontend/Dockerfile"
    "web-frontend/package.json"
)

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✅ $file"
    else
        echo "  ❌ $file (missing)"
    fi
done

echo ""
echo "🚀 Ready to run: docker compose up"
echo ""
echo "📖 For more details, see: LOCAL_DOCKER_GUIDE.md"
