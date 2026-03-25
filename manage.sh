#!/bin/bash
# ============================================================
# manage.sh — Start, stop, monitor the microservices stack
# ============================================================

set -e

ACTION=$1

print_usage() {
    echo "Usage: ./manage.sh [start|stop|restart|status|logs|clean]"
}

start_stack() {
    echo "🚀 Starting microservices stack..."
    docker-compose up -d --build
    echo ""
    echo "⏳ Waiting for services to be healthy..."
    sleep 15
    docker-compose ps
    echo ""
    echo "✅ Stack is running!"
    echo "   App:     http://localhost"
    echo "   API:     http://localhost/api"
}

stop_stack() {
    echo "⏹️  Stopping stack..."
    docker-compose down
    echo "✅ Stack stopped."
}

restart_stack() {
    stop_stack
    sleep 3
    start_stack
}

status_stack() {
    echo "📋 Container Status:"
    docker-compose ps
    echo ""
    echo "📊 Resource Usage:"
    docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"
}

show_logs() {
    SERVICE=${2:-""}
    if [ -z "$SERVICE" ]; then
        docker-compose logs -f --tail=50
    else
        docker-compose logs -f --tail=50 "$SERVICE"
    fi
}

clean_stack() {
    echo "🗑️  Removing all containers, networks, and volumes..."
    docker-compose down -v --remove-orphans
    docker system prune -f
    echo "✅ Cleanup complete."
}

case "$ACTION" in
    start)   start_stack ;;
    stop)    stop_stack ;;
    restart) restart_stack ;;
    status)  status_stack ;;
    logs)    show_logs $@ ;;
    clean)   clean_stack ;;
    *)       print_usage ;;
esac
