#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}🔧 Setting up environment...${NC}"
echo -e "${YELLOW}**************************************************************************************************************************${NC}"

# Check Docker
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker not found. Please install Docker.${NC}"
    exit 1
fi

# Check Docker Compose
if ! docker compose version &> /dev/null && ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}❌ Docker Compose not found. Please install Docker Compose.${NC}"
    exit 1
fi

echo -e "${YELLOW}**************************************************************************************************************************${NC}"
echo -e "${GREEN}✅ Docker and Docker Compose are installed.${NC}"
echo -e "${YELLOW}**************************************************************************************************************************${NC}"

# Build and start services
echo -e "${BLUE}🚀 Starting services with Docker Compose...${NC}"
docker compose up 

echo -e "${YELLOW}**************************************************************************************************************************${NC}"

# Check container health
echo -e "${CYAN}📋 Checking container health...${NC}"
docker ps --format "table {{.Names}}\t{{.Status}}"

echo -e "${YELLOW}**************************************************************************************************************************${NC}"

# Show logs
echo -e "${CYAN}📂 Logs:${NC}"
docker compose logs --tail=20

echo -e "${YELLOW}**************************************************************************************************************************${NC}"
