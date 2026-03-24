# 🚀 Rosecal Lead Generation - N8N en Render

Sistema automatizado de lead generation para Rosecal (indumentaria de trabajo) ejecutándose en Render.

## 📦 Contenido

```
📁 workflows/          ← Workflows JSON listos para importar
📁 docs/               ← Documentación completa
📄 Dockerfile          ← Config Docker para Render
📄 render.yaml         ← Config Render
```

## 🚀 Deploy en Render

Este repo está configurado para deployar automáticamente en Render usando Docker.

### 1. Configurar variables de entorno en Render

Ir a Dashboard → Select Web Service → Settings → Environment:

```bash
# Google Sheets
GOOGLE_SHEETS_ID=1ABC123...tu-id...

# Info del vendedor
NOMBRE_VENDEDOR=Juan Pérez
TELEFONO_VENDEDOR=+54 11 5555-5555
EMAIL_NOTIFICACIONES=notificaciones@rosecal.com
GMAIL_ADDRESS=ventas@rosecal.com

# n8n config
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=tu-password-segura
N8N_ENCRYPTION_KEY=tu-encryption-key
WEBHOOK_URL=https://n8n-tuapp.onrender.com/
```

### 2. Credenciales en n8n

Una vez deployado, acceder a n8n e ir a **Settings → Credentials**:

1. **Google Sheets** - OAuth2
2. **Gmail** - OAuth2
3. **Google Calendar** - OAuth2
4. **OpenAI** - API Key
5. **Apollo.io** - Header Auth (X-Api-Key)

## 📥 Importar Workflows

1. Ir a **Workflows → Import from JSON**
2. Importar en este orden:
   - `00-Rosecal-Importacion-Leads.json` (opcional si usás Apollo API)
   - `01-Rosecal-Secuencia-Emails.json`
   - `02-Rosecal-Clasificacion-Respuestas.json`
   - `03-Rosecal-Recordatorios-Futura.json`
   - `04-Rosecal-Apollo-Busqueda.json` (recomendado)
3. Asignar credenciales a cada nodo
4. Activar workflows (toggle ON)

## 🔄 Flujo Automático

```
Lunes 10AM → Apollo Busca Leads → Sheets
Diario 9AM → Envía Emails → Sheets
Cada hora → Lee Gmail → Clasifica → Notifica
On-demand → Fecha Futura → Calendar
```

## 📖 Documentación

Ver carpeta `docs/`:
- `START-HERE.md` - Guía rápida
- `APOLLO-GUIDE.md` - Configuración Apollo API
- `SETUP-GUIDE.md` - Credenciales y variables
- `GOOGLE-SHEETS-STRUCTURE.md` - Estructura de columnas

## 💰 Costos

| Servicio | Costo mensual |
|----------|---------------|
| Render Web Service | $0-7 (Starter) |
| OpenAI API | ~$10 |
| Apollo.io (opcional) | $49 |
| **Total** | **~$10-66/mes** |

## 🆘 Soporte

- n8n Docs: https://docs.n8n.io/
- Render Docs: https://render.com/docs

---

**Deploy status:** [![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

**Nota:** Este repo contiene los archivos JSON de workflows. Para ejecutarlos necesitás una instancia de n8n funcionando.
