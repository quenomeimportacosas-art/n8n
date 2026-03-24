#!/bin/sh
set -e

echo "=== n8n Startup Script ==="
echo "Esperando que la base de datos esté lista..."

# Esperar hasta 60 segundos a que PostgreSQL responda
MAX_RETRIES=12
RETRY_COUNT=0

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
  if wget --spider --quiet "http://localhost:5678/healthz" 2>/dev/null; then
    echo "n8n ya está corriendo!"
    break
  fi
  
  echo "Intento $((RETRY_COUNT + 1))/$MAX_RETRIES - Iniciando n8n..."
  RETRY_COUNT=$((RETRY_COUNT + 1))
  
  # Intentar conectar a la DB
  if [ -n "$DB_POSTGRESDB_HOST" ]; then
    echo "Verificando conexión a PostgreSQL en $DB_POSTGRESDB_HOST:$DB_POSTGRESDB_PORT..."
  fi
  
  sleep 5
done

echo "Iniciando n8n..."
exec n8n start
