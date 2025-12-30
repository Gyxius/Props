#!/bin/bash
# Simple script to ping the backend and wake it up

echo "🔄 Pinging backend to wake it up..."
echo "This may take 30-60 seconds if the service is sleeping..."
echo ""

# Try the /users endpoint (health check)
echo "Testing /users endpoint..."
response=$(curl -s -w "\nHTTP_CODE:%{http_code}" --max-time 90 https://fast-api-backend-qlyb.onrender.com/users)
http_code=$(echo "$response" | grep "HTTP_CODE" | cut -d: -f2)

if [ "$http_code" = "200" ]; then
    echo "✅ Backend is responding! HTTP $http_code"
    echo "You can now try creating your event"
else
    echo "⚠️  Backend returned HTTP $http_code or timed out"
    echo "Wait a minute and run this script again"
fi

echo ""
echo "Response preview:"
echo "$response" | grep -v "HTTP_CODE" | head -20
