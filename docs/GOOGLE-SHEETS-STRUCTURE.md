# Estructura de Google Sheets - Rosecal Leads

## Hoja: Leads

Copiar exactamente estas columnas en la fila 1:

| Columna | Descripción | Ejemplo |
|---------|-------------|---------|
| `empresa` | Nombre de la empresa | Metalúrgica Pérez S.A. |
| `rubro` | Industria/rubro | Manufactura |
| `zona` | Ubicación geográfica | Buenos Aires |
| `empleados_aprox` | Cantidad aproximada | 150 |
| `web` | Sitio web | www.empresa.com |
| `nombre_contacto` | Nombre del contacto | Juan García |
| `cargo_contacto` | Cargo | Jefe de Compras |
| `email_contacto` | Email (clave única) | juan@empresa.com |
| `telefono_empresa` | Teléfono | +54 11 5555-5555 |
| `estado` | Estado actual | pendiente |
| `email_enviado_1` | Si/No (fecha) | 2024-03-15 |
| `email_enviado_2` | Si/No (fecha) | - |
| `email_enviado_3` | Si/No (fecha) | - |
| `fecha_ultimo_contacto` | ISO Date | 2024-03-15T09:00:00Z |
| `fecha_respuesta` | ISO Date | - |
| `categoria_respuesta` | Categoría IA | INTERESADO |
| `resumen_respuesta` | Texto breve | "Quiere precios para 80" |
| `accion_sugerida` | Acción | llamar hoy |
| `urgencia` | alta/media/baja | alta |
| `fecha_futura` | Fecha compra | 15/06/2024 |
| `notas_call` | Notas | Llamar martes |
| `call_resultado` | Resultado llamada | habló |
| `call_detalle` | Qué dijo | Pide cotización |
| `proxima_accion` | Siguiente paso | enviar cotización |
| `fecha_proximo_contacto` | Cuándo | 2024-03-20 |

## Estados posibles (columna: estado)

```
pendiente
email1_enviado
email2_enviado
email3_enviado
respondio
excluido
no_es_compras
verificar_cargo
```

## Categorías de respuesta (columna: categoria_respuesta)

```
INTERESADO
FECHA_FUTURA
DERIVA_CONTACTO
TIENE_PROVEEDOR
NO_INTERESADO
BOUNCE_SPAM
```

## Ejemplo de fila completa

```
Metalúrgica Pérez S.A. | Manufactura | Buenos Aires | 150 | www.metalurgicaperez.com | Juan García | Jefe de Compras | juan@metalurgicaperez.com | +54 11 4444-5555 | pendiente | | | | | | | | | | | | | | |
```

## Plantilla para importación

CSV compatible con Apollo.io:
```csv
empresa,rubro,zona,empleados_aprox,web,nombre_contacto,cargo_contacto,email_contacto,telefono_empresa
Empresa Demo,Manufactura,Buenos Aires,120,www.demo.com,Carlos López,Jefe de Compras,carlos@demo.com,+54 11 5555-5555
```

## Formato de fechas

- `fecha_ultimo_contacto`: ISO 8601 (2024-03-15T09:00:00Z)
- `fecha_respuesta`: ISO 8601
- `fecha_futura`: dd/MM/yyyy (15/06/2024)
- `fecha_proximo_contacto`: ISO 8601

## Notas importantes

1. **email_contacto** debe ser único (clave primaria)
2. **estado** debe ser exactamente uno de los valores listados
3. **categoria_respuesta** se actualiza automáticamente por el workflow 02
4. No borrar columnas vacías, el workflow espera que existan
5. Las filas 2 en adelante son para los datos

## Permisos de Google Sheets

Compartir la hoja con la cuenta de servicio de n8n (o con acceso OAuth) con permisos de:
- Lectura (para leer leads)
- Escritura (para actualizar estados)
