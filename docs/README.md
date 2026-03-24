# Rosecal - Workflow de Lead Generation para N8N

Este repositorio contiene los 4 workflows principales para el sistema automatizado de lead generation de Rosecal (indumentaria de trabajo).

## Workflows incluidos

| # | Workflow | Descripción | Frecuencia |
|---|----------|-------------|------------|
| 00 | Importación de Leads | Importa CSVs de Apollo/Evaboot y valida cargos | Manual |
| 01 | Secuencia de Emails | Envía emails personalizados diariamente | Diario 9AM |
| 02 | Clasificación de Respuestas | Lee Gmail y clasifica respuestas con Claude | Cada 60 min |
| 03 | Recordatorios Fecha Futura | Crea eventos en Calendar para fechas futuras | On-demand |
| 04 | Apollo Búsqueda | Busca leads automáticamente en Apollo.io | Semanal |

## Requisitos previos

### 1. Cuentas y APIs necesarias

- **n8n** (cloud o self-hosted) - https://n8n.io/
- **Google Cloud Console** (para Sheets, Gmail, Calendar)
- **OpenAI API** (para Claude/personalización)
- **Cuenta de WhatsApp Business** (opcional, para notificaciones)

### 2. Credenciales a configurar en n8n

Ve a **Settings > Credentials** y agregá:

1. **Google Sheets OAuth2** - Acceso a spreadsheets
2. **Gmail OAuth2** - Para enviar y recibir emails
3. **Google Calendar OAuth2** - Para crear recordatorios
4. **OpenAI API** - Modelo GPT-4o-mini o similar
5. **Apollo.io API** - Para búsqueda automática de leads (opcional)
6. **WhatsApp Business** (opcional) - Para notificaciones urgentes

### Configuración especial: Apollo.io API

Para el workflow 04 necesitás:
1. Crear cuenta en Apollo.io (plan básico $49/mes)
2. Ir a Settings → API Keys → Create New Key
3. En n8n, crear credencial tipo **Header Auth**:
   - Name: `X-Api-Key`
   - Value: `tu-api-key-de-apollo`

### 3. Variables de entorno (Settings > Variables)

```
GOOGLE_SHEETS_ID = ID-de-tu-hoja-de-leads
GMAIL_ADDRESS = tu-email@gmail.com
NOMBRE_VENDEDOR = Tu Nombre
TELEFONO_VENDEDOR = +54 11 XXXX-XXXX
EMAIL_NOTIFICACIONES = email-para-notificaciones@gmail.com
```

## Instalación

### Paso 1: Crear Google Sheets

1. Crear una nueva hoja de cálculo llamada **"Rosecal - Leads"**
2. Nombrar la primera pestaña como **"Leads"**
3. Agregar estas columnas en la primera fila:

```
empresa | rubro | zona | empleados_aprox | web | nombre_contacto | cargo_contacto | email_contacto | telefono_empresa | estado | email_enviado_1 | email_enviado_2 | email_enviado_3 | fecha_ultimo_contacto | fecha_respuesta | categoria_respuesta | resumen_respuesta | accion_sugerida | urgencia | fecha_futura | notas_call | call_resultado | call_detalle | proxima_accion | fecha_proximo_contacto
```

4. Copiar el ID de la hoja (está en la URL: `/d/`**ID**`/edit`)
5. Guardarlo en la variable `GOOGLE_SHEETS_ID`

### Paso 2: Importar workflows

1. En n8n, ve a **Workflows > Import from JSON**
2. Importar en este orden:
   - `00-Rosecal-Importacion-Leads.json`
   - `01-Rosecal-Secuencia-Emails.json`
   - `02-Rosecal-Clasificacion-Respuestas.json`
   - `03-Rosecal-Recordatorios-Futura.json`
   - `04-Rosecal-Apollo-Busqueda.json` (opcional)

### Paso 3: Configurar credenciales

En cada workflow, revisar los nodos marcados con ⚠️ y:
1. Seleccionar las credenciales correspondientes
2. Guardar el workflow
3. Activar el workflow (toggle en ON)

## Flujo de trabajo

### 1. Buscar leads automáticamente (Workflow 04 - Opcional)

Este workflow reemplaza la importación manual de CSVs:

1. Corre automáticamente todos los lunes a las 10AM
2. Busca en Apollo.io contactos con cargo de compras en Argentina
3. Filtra por industrias: Manufactura, Construcción, Logística, Alimentos
4. Verifica que el email no exista ya en Sheets (evita duplicados)
5. Claude valida que el cargo sea de compras
6. Agrega automáticamente a Google Sheets con estado "pendiente"
7. Envía notificación con resumen de leads importados

**Filtros aplicados automáticamente:**
- País: Argentina
- Cargo: jefe de compras, encargado de compras, purchasing manager
- Empleados: 50-1000
- Industrias: Manufacturing, Construction, Food & Beverages, Transportation

### 2. Importar leads manual (Workflow 00)

Alternativa si no usás Apollo API:
1. Exportar CSV desde Apollo.io o Evaboot
2. Ir al workflow "Importación de Leads"
3. Ejecutar manualmente
4. Subir el CSV cuando se solicite
5. El workflow valida automáticamente si el cargo es de compras

### 3. Enviar emails (Workflow 01 - Automático)

- Corre todos los días a las 9:00 AM
- Lee leads con estado "pendiente", "email1_enviado", "email2_enviado"
- Claude personaliza cada email según el rubro
- Actualiza automáticamente el estado en Sheets

### 4. Clasificar respuestas (Workflow 02 - Automático)

- Revisa Gmail cada hora
- Filtra respuestas a emails de Rosecal
- Claude clasifica en: INTERESADO, FECHA_FUTURA, DERIVA_CONTACTO, etc.
- Notifica por WhatsApp/Email si es INTERESADO
- Actualiza Google Sheets con la clasificación

### 5. Seguimiento de fechas futuras (Workflow 03)

- Se activa cuando un lead tiene fecha_futura
- Crea evento en Google Calendar 30 días antes
- Envía confirmación por email

## Estados posibles de los leads

| Estado | Significado |
|--------|-------------|
| pendiente | Listo para recibir Email 1 |
| email1_enviado | Esperando respuesta o pasaron < 6 días |
| email2_enviado | Email 2 enviado, esperando o < 7 días |
| email3_enviado | Email 3 enviado, listo para cold call |
| respondio | El lead respondió algún email |
| excluido | Opt-out, no contactar |
| no_es_compras | Cargo no es de compras |

## Categorías de respuesta

- **INTERESADO** → Notificación inmediata, llamar hoy
- **FECHA_FUTURA** → Calendar automático, recordatorio 30 días antes
- **DERIVA_CONTACTO** → Agrega nuevo contacto a Sheets
- **TIENE_PROVEEDOR** → Archivar, recontactar en 6 meses
- **NO_INTERESADO** → Opt-out, nunca más contactar
- **BOUNCE_SPAM** → Email inválido, buscar alternativo

## Personalización

### Prompts de Claude

Los prompts están en los nodos AI. Podés ajustarlos según:
- Tu estilo de comunicación
- Productos específicos de Rosecal
- Zonas geográficas

### Frecuencia de emails

Editar los nodos "¿Email 1 + 6 días?" y "¿Email 2 + 7 días?" para cambiar:
- Días de espera entre emails
- Horario de envío

### Notificaciones

En el workflow 02, podés agregar más canales:
- Slack
- Telegram
- SMS (Twilio)

## Troubleshooting

### Los emails no se envían
- Verificar credenciales de Gmail
- Revisar cuota diaria de Gmail
- Check logs en n8n

### Claude no responde
- Verificar API key de OpenAI
- Check crédito disponible
- Revisar formato del prompt

### No se actualiza Sheets
- Verificar que el ID de la hoja sea correcto
- Confirmar permisos de OAuth
- Verificar que las columnas existan

## Soporte

Para dudas sobre n8n: https://docs.n8n.io/
Para ajustes en los workflows, editar directamente en el nodo correspondiente.

---

**Nota:** Estos workflows usan expresiones de n8n ({{ }}) y variables de entorno. No compartir las credenciales ni API keys.
