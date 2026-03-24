# Configuración de Variables de Entorno para Rosecal

## Variables necesarias en n8n

Ir a: Settings → Variables

### Google Sheets
```
Nombre: GOOGLE_SHEETS_ID
Valor: 1ABC123def456GHI789jkl... (ID de tu hoja de leads)
```

### Información del vendedor
```
Nombre: NOMBRE_VENDEDOR
Valor: Juan Pérez
```

```
Nombre: TELEFONO_VENDEDOR
Valor: +54 11 5555-5555
```

```
Nombre: EMAIL_NOTIFICACIONES
Valor: tu-email@gmail.com
```

```
Nombre: GMAIL_ADDRESS
Valor: rosecal.ventas@gmail.com
```

## Credenciales necesarias (Settings → Credentials)

### 1. Google Sheets
- **Type:** OAuth2
- **Scopes needed:**
  - https://www.googleapis.com/auth/spreadsheets
  - https://www.googleapis.com/auth/drive.readonly

### 2. Gmail
- **Type:** OAuth2
- **Scopes needed:**
  - https://www.googleapis.com/auth/gmail.send
  - https://www.googleapis.com/auth/gmail.readonly
  - https://www.googleapis.com/auth/gmail.modify

### 3. Google Calendar
- **Type:** OAuth2
- **Scopes needed:**
  - https://www.googleapis.com/auth/calendar
  - https://www.googleapis.com/auth/calendar.events

### 4. OpenAI
- **Type:** OpenAI API
- **API Key:** sk-... (tu API key)

### 5. WhatsApp (opcional)
- **Type:** WhatsApp Business Cloud
- **Access Token:** ...
- **Phone Number ID:** ...

## Configuración de Google Cloud Console

### Paso 1: Crear proyecto
1. Ir a https://console.cloud.google.com/
2. Crear nuevo proyecto: "Rosecal-n8n"

### Paso 2: Habilitar APIs
1. Ir a "APIs & Services" → "Library"
2. Habilitar:
   - Google Sheets API
   - Gmail API
   - Google Calendar API

### Paso 3: Pantalla de consentimiento OAuth
1. Ir a "OAuth consent screen"
2. Tipo: External
3. Completar información básica
4. Agregar scopes:
   - .../auth/spreadsheets
   - .../auth/gmail.send
   - .../auth/gmail.readonly
   - .../auth/calendar

### Paso 4: Crear credenciales OAuth 2.0
1. Ir a "Credentials" → "Create Credentials" → "OAuth client ID"
2. Tipo: Web application
3. Agregar URIs:
   - https://TU-INSTANCIA-N8N.n8n.cloud/rest/oauth2-credential/callback
4. Guardar Client ID y Client Secret

### Paso 5: Conectar en n8n
1. En n8n, crear nueva credencial Google Sheets OAuth2
2. Pegar Client ID y Client Secret
3. Click "Connect" y autorizar
4. Repetir para Gmail y Calendar

## Verificación

Ejecutar este workflow de prueba:

```json
{
  "name": "Test - Rosecal Config",
  "nodes": [
    {
      "parameters": {},
      "name": "Manual Trigger",
      "type": "n8n-nodes-base.manualTrigger",
      "typeVersion": 1,
      "position": [250, 300]
    },
    {
      "parameters": {
        "operation": "read",
        "documentId": "={{ $env.GOOGLE_SHEETS_ID }}",
        "sheetName": "Leads",
        "limitRows": 1
      },
      "name": "Test Sheets",
      "type": "n8n-nodes-base.googleSheets",
      "typeVersion": 4.5,
      "position": [450, 300]
    }
  ],
  "connections": {
    "Manual Trigger": {
      "main": [[{"node": "Test Sheets", "type": "main", "index": 0}]]
    }
  }
}
```

Si lee datos de Sheets, la configuración está correcta.
