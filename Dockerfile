FROM n8nio/n8n:latest

# n8n puerto por defecto. Render automáticamente mapeará su puerto asignado a este si lo detecta, 
# pero siempre es buena práctica exponerlo
EXPOSE 5678

# Arrancamos n8n
CMD ["n8n", "start"]
