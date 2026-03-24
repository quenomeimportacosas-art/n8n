# 🚀 Rosecal - Sistema de Lead Generation

## 📦 Archivos del Sistema

### Workflows N8N (Importar en orden)

```
┌─────────────────────────────────────────────────────────────────┐
│  00-Rosecal-Importacion-Leads.json     ← CSV Manual (Opcional)  │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│  04-Rosecal-Apollo-Busqueda.json       ← Búsqueda Automática    │
│                                          (Reemplaza al 00)      │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│  01-Rosecal-Secuencia-Emails.json      ← Emails Diarios con IA  │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│  02-Rosecal-Clasificacion-Respuestas.json ← Lee Gmail/Clasifica │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│  03-Rosecal-Recordatorios-Futura.json  ← Calendar Alerts      │
└─────────────────────────────────────────────────────────────────┘
```

---

## 📖 Documentación

| Archivo | Para qué sirve | Tiempo lectura |
|---------|----------------|----------------|
| **README.md** | Guía completa de instalación y uso | 10 min |
| **SETUP-GUIDE.md** | Configuración paso a paso de credenciales | 15 min |
| **APOLLO-GUIDE.md** | Cómo configurar API de Apollo | 10 min |
| **GOOGLE-SHEETS-STRUCTURE.md** | Estructura exacta de columnas | 5 min |
| **RESUMEN.md** | Estado del proyecto y checklist | 5 min |

---

## ⚡ Inicio Rápido (5 pasos)

### Paso 1: Preparar Google Sheets
- [ ] Crear hoja "Rosecal - Leads"
- [ ] Copiar columnas de GOOGLE-SHEETS-STRUCTURE.md
- [ ] Guardar ID de la hoja

### Paso 2: Configurar n8n
- [ ] Crear cuenta en n8n.io
- [ ] Agregar variables de entorno (SETUP-GUIDE.md)
- [ ] Configurar credenciales OAuth de Google

### Paso 3: Elegir modo de importación

**Opción A - Automático (Recomendado):**
- [ ] Crear cuenta Apollo.io ($49/mes)
- [ ] Configurar API key (APOLLO-GUIDE.md)
- [ ] Importar workflow 04

**Opción B - Manual:**
- [ ] Importar workflow 00
- [ ] Exportar CSVs de Apollo manualmente

### Paso 4: Configurar el resto
- [ ] Importar workflows 01, 02, 03
- [ ] Agregar API key de OpenAI
- [ ] Asignar credenciales a cada nodo

### Paso 5: Activar
- [ ] Activar todos los workflows
- [ ] Probar con 1 lead de prueba
- [ ] Esperar resultados 🎉

---

## 📊 Flujo de Trabajo

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│   Apollo.io  │────▶│     n8n      │────▶│ Google Sheets│
│  (Búsqueda)  │     │  (Procesa)   │     │   (Guarda)   │
└──────────────┘     └──────────────┘     └──────────────┘
                                                        │
                              ┌─────────────────────────┘
                              ▼
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│    Gmail     │◀────│  Secuencia   │◀────│  Leer Lead   │
│   (Envía)    │     │   Emails     │     │   (9AM)      │
└──────────────┘     └──────────────┘     └──────────────┘
        │
        ▼
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│  Respuesta   │────▶│ Claude Clasifica │─▶│  Notificación │
│   (Lead)     │     │  (6 categorías)  │  │ (WhatsApp/Email)│
└──────────────┘     └──────────────┘     └──────────────┘
        │
        ▼
┌──────────────┐
│ Fecha Futura │────▶ Google Calendar (30 días antes)
└──────────────┘
```

---

## 💰 Inversión Mensual

| Servicio | Costo | ¿Necesario? |
|----------|-------|-------------|
| n8n Cloud | $20-50 | ✅ Sí |
| OpenAI API | ~$10 | ✅ Sí |
| Apollo.io | $49 | ⚠️ Opcional |
| WhatsApp API | ~$5 | ⚠️ Opcional |
| **Mínimo** | **~$30** | Sin Apollo |
| **Completo** | **~$80** | Con Apollo |

---

## 🎯 Resultados Esperados

- **40-60%** tasa de apertura de emails
- **8-15%** tasa de respuesta
- **2-5%** leads calificados
- **~10hs semanales** ahorradas vs manual

---

## 🆘 Soporte Rápido

| Problema | Solución |
|----------|----------|
| No se conecta a Sheets | Verificar ID y OAuth scopes |
| Claude no responde | Revisar API key y crédito OpenAI |
| Emails no se envían | Cuota Gmail (500/día) |
| Apollo no devuelve nada | Verificar API key y plan activo |

---

## 📞 Recursos

- **n8n Docs:** https://docs.n8n.io/
- **Expresiones:** https://docs.n8n.io/code/cookbook/
- **OpenAI:** https://platform.openai.com/docs
- **Apollo API:** https://apolloio.github.io/apollo-api-docs/

---

**Versión:** 1.1 | **Actualizado:** 2024
