# Guía de Configuración - Apollo.io API

## ¿Qué hace el Workflow 04?

Este workflow automatiza la búsqueda de leads en Apollo.io, eliminando la necesidad de exportar CSVs manualmente.

### Funciones:
- Busca contactos con cargo de compras en Argentina
- Filtra por industrias objetivo (Manufactura, Construcción, Logística, Alimentos)
- Evita duplicados verificando emails existentes
- Valida automáticamente si el cargo es de compras con Claude
- Agrega leads calificados directamente a Google Sheets

---

## Paso 1: Obtener API Key de Apollo

1. Ir a https://app.apollo.io/
2. Iniciar sesión con tu cuenta (plan básico $49/mes o superior)
3. Click en tu avatar (arriba a la derecha) → Settings
4. En el menú lateral, ir a **API Keys**
5. Click en **Create New Key**
6. Nombre: "n8n-integration"
7. Copiar la API key generada (empieza con algo como `x-xxxxxxxx...`)

---

## Paso 2: Configurar Credencial en n8n

1. En n8n, ir a **Settings** → **Credentials**
2. Click en **Add Credential**
3. Buscar **Header Auth**
4. Completar:
   - **Name**: Apollo API
   - **Header Name**: `X-Api-Key`
   - **Header Value**: (pegar tu API key de Apollo)
5. Guardar

---

## Paso 3: Configurar el Workflow

1. Importar `04-Rosecal-Apollo-Busqueda.json`
2. Abrir el nodo "Apollo - Buscar Contactos"
3. En **Authentication**, seleccionar la credencial "Apollo API" creada
4. Guardar el workflow
5. Activar (toggle ON)

---

## Filtros de Búsqueda (Personalizables)

El workflow busca automáticamente contactos que coincidan con:

### Ubicación
- País: Argentina
- Ciudad: Cualquiera

### Cargo (keywords)
```
jefe de compras
encargado de compras
responsable de compras
purchasing manager
abastecimiento
```

### Tamaño de empresa
- 50 a 1000 empleados

### Industrias (IDs de Apollo)
- `5567e0e77369642d5f080000` - Manufacturing
- `5567e0e77369642d5f0c0000` - Construction
- `5567e0e77369642d5f1e0000` - Food & Beverages
- `5567e0e77369642d5f220000` - Transportation

### Para modificar industrias:

1. Ir a Apollo.io → Search → Organizations
2. Aplicar filtro de industria deseada
3. Inspeccionar el código de la página (F12)
4. Buscar el ID de la industria en el payload de la API
5. Reemplazar en el nodo "Apollo - Buscar Contactos"

---

## Limitaciones de Apollo API

| Plan | Límites |
|------|---------|
| Free | No incluye API access |
| Basic ($49/mes) | 1,000 requests/mes |
| Professional ($99/mes) | 5,000 requests/mes |
| Enterprise | Ilimitado |

**Cada ejecución del workflow = 1 request**

Si necesitás más resultados, podés:
1. Modificar el parámetro `per_page` (máximo 100)
2. Agregar paginación recorriendo múltiples páginas
3. Ejecutar el workflow más frecuentemente (ej: 2 veces por semana)

---

## Personalizar la Búsqueda

### Cambiar frecuencia

Por defecto corre **todos los lunes a las 10AM**.

Para cambiar:
1. Abrir nodo "Schedule - Semanal Lunes 10AM"
2. Modificar la regla:
   - **Every week**: Ejecutar semanalmente
   - **Every day**: Ejecutar diariamente
   - **Custom**: Definir días específicos

### Cambiar filtros de búsqueda

En el nodo "Apollo - Buscar Contactos", editar el **Body**:

```json
{
  "organization_locations": ["Argentina"],
  "person_locations": ["Argentina"],
  "contact_email_status": ["verified", "likely_verified"],
  "q_keywords": "jefe de compras OR encargado de compras",
  "organization_num_employees_range": ["50-100", "100-200"],
  "organization_industry_tag_ids": ["ID_1", "ID_2"],
  "per_page": 100,
  "page": 1
}
```

### Agregar más campos

Si necesitás más datos de Apollo, podés agregar campos al mapeo en el nodo "Transformar Datos Apollo":

```javascript
linkedin_url: person.linkedin_url || '',
twitter_url: person.twitter_url || '',
apollo_id: person.id,
// etc.
```

---

## Troubleshooting

### "401 Unauthorized"
→ La API key es incorrecta o expiró
→ Crear nueva key en Apollo

### "No results found"
→ Los filtros son demasiado restrictivos
→ Probar con keywords más amplios
→ Verificar que Apollo tenga datos de esa industria en Argentina

### "Email already exists"
→ Esto es normal - el workflow evita duplicados
→ El lead ya está en tu base de datos

### "Rate limit exceeded"
→ Apollo tiene límites por plan
→ Reducir la frecuencia de ejecución
→ O actualizar a plan superior

---

## Alternativa: Importación Manual

Si no querés usar la API de Apollo, podés seguir usando el **Workflow 00**:

1. Exportar CSV desde Apollo.io (manual)
2. Ejecutar Workflow 00
3. Subir el CSV
4. El workflow hace lo mismo: valida, transforma y carga a Sheets

---

## Recursos

- Documentación Apollo API: https://apolloio.github.io/apollo-api-docs/
- Postman Collection: https://www.postman.com/apolloio
- Límites API: https://apolloio.zendesk.com/hc/en-us/articles/4413698162445
