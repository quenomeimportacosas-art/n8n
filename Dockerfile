FROM n8nio/n8n:latest

# Health check para Render
HEALTHCHECK --interval=30s --timeout=10s --start-period=90s --retries=5 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:5678/healthz 2>/dev/null || exit 1

EXPOSE 5678
