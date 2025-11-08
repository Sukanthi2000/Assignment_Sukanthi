#!/bin/bash

echo "🔧 Setting up environment..."

# Check Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker not found. Please install Docker."
    exit 1
fi

if ! docker compose version &> /dev/null && ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose not found. Please install Docker Compose."
    exit 1
fi


echo "✅ Docker and Docker Compose are installed."

# Build and start services
echo "🚀 Starting services with Docker Compose..."
docker-compose up -d --build

echo "📋 Checking container health..."
docker ps --format "table {{.Names}}\t{{.Status}}"

echo "📂 Logs:"
docker-compose logs --tail=20
