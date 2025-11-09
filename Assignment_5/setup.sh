#!/usr/bin/env bash
set -euo pipefail

# Basic helper script to prepare local host and start docker-compose stack.
# Usage: sudo ./setup.sh   (some installs require sudo)
# Note: script prints instructions rather than forcibly installing in some systems.

WORKDIR="$(cd "$(dirname "$0")" && pwd)"
COMPOSE_FILE="$WORKDIR/docker-compose.yml"

echo "== Infra setup script =="
echo "Working directory: $WORKDIR"

# --- Check docker ---
if ! command -v docker >/dev/null 2>&1; then
  echo "Docker not found. Please install Docker first."
  echo "Ubuntu: sudo apt update && sudo apt install -y docker.io"
  echo "Amazon Linux 2: sudo yum install -y docker"
  echo "Then: sudo systemctl start docker && sudo usermod -aG docker \$USER"
  exit 1
fi

# --- Check docker-compose ---
if ! command -v docker-compose >/dev/null 2>&1; then
  if docker compose version >/dev/null 2>&1; then
    echo "Using docker CLI 'docker compose'"
    DOCKER_COMPOSE_CMD="docker compose"
  else
    echo "docker-compose not found. Install docker-compose or use Docker CLI v2 (docker compose)."
    echo "Ubuntu example: sudo apt install -y docker-compose-plugin"
    exit 1
  fi
else
  DOCKER_COMPOSE_CMD="docker-compose"
fi

echo "Using compose command: $DOCKER_COMPOSE_CMD"

# Build local sample app image
echo "Building sample-app..."
$DOCKER_COMPOSE_CMD build --pull --no-cache sample-app

# Start stack
echo "Starting stack..."
$DOCKER_COMPOSE_CMD up -d

# Wait for health checks to turn healthy (max 120s)
echo "Waiting for services to report healthy status..."
MAX_RETRIES=24
SLEEP=5
count=0

check_health() {
  # returns 0 if all healthy or no healthcheck defined
  local all_ok=0
  for svc in infra_jenkins infra_redis infra_sample_app infra_nginx; do
    if docker inspect --format='{{json .State.Health}}' "$svc" >/dev/null 2>&1; then
      state=$(docker inspect --format='{{.State.Health.Status}}' "$svc")
      if [ "$state" != "healthy" ]; then
        echo "Service $svc health: $state"
        all_ok=1
      fi
    else
      # no health info: check running state
      running=$(docker inspect --format='{{.State.Running}}' "$svc" 2>/dev/null || echo "false")
      if [ "$running" != "true" ]; then
        echo "Service $svc not running"
        all_ok=1
      fi
    fi
  done
  return $all_ok
}

while (( count < MAX_RETRIES )); do
  if check_health; then
    echo "Waiting ${SLEEP}s..."
    sleep $SLEEP
    count=$((count+1))
  else
    echo "All services are healthy (or running)."
    break
  fi
done

echo "Services status:"
$DOCKER_COMPOSE_CMD ps

# Print endpoints
echo
echo "Access endpoints (host:port):"
echo " - Jenkins: http://localhost:8080 (initial admin password: see container logs)"
echo " - Redis: localhost:6379"
echo " - Sample App: http://localhost:5000"
echo " - Nginx (reverse proxy): http://localhost:80"

echo
echo "To tail logs:"
echo " $ $DOCKER_COMPOSE_CMD logs -f --tail=200"
echo
echo "To view Jenkins initial admin password:"
echo " $ docker logs infra_jenkins 2>/dev/null | sed -n '1,200p' | grep -i '********' -n || docker logs infra_jenkins | sed -n '1,200p'"

echo
echo "If any service fails health, check logs with:"
echo " $ $DOCKER_COMPOSE_CMD logs <service>"
echo
echo "Done."
