# 🚀 Guía de Despliegue en Render - Tienda Virtual PHP

## 🎯 ¿Por qué Render es Mejor para PHP?

Render está diseñado específicamente para aplicaciones web tradicionales como PHP:

### ✅ Ventajas de Render vs Vercel
- **Soporte nativo PHP** con Apache/Nginx completo
- **Base de datos PostgreSQL gratuita** incluida
- **Sistema de archivos completo** sin restricciones
- **Sesiones PHP tradicionales** sin límites
- **URL rewriting completo** (.htaccess compatible)
- **Subida de archivos** sin problemas
- **Variables de entorno ilimitadas**
- **SSL gratuito** y dominios personalizados

## 🏗️ Arquitectura en Render

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Frontend      │    │   Backend PHP    │    │  PostgreSQL DB  │
│   (HTML/CSS/JS) │◄──►│   (MVC Completo) │◄──►│   (Incluida)    │
└─────────────────┘    └──────────────────┘    └─────────────────┘
       │                        │                        │
       └────────────────────────┼────────────────────────┘
                                │
                        ┌──────────────────┐
                        │   Render CDN     │
                        │   (Global)       │
                        └──────────────────┘
```

## 🚀 Pasos de Despliegue

### 1. Crear Cuenta en Render
- Visita: https://render.com/
- Regístrate con GitHub/GitLab/Bitbucket
- Verifica tu email

### 2. Crear Nuevo Servicio Web
1. Click en **"New +"** → **"Web Service"**
2. Conecta tu repositorio de GitHub
3. Configura los siguientes parámetros:

#### Configuración del Servicio
```yaml
Name: tienda-virtual-php
Environment: PHP
Region: Oregon (o la más cercana)
Branch: master
Root Directory: ./
Build Command: composer install --no-dev
Start Command: php -S 0.0.0.0:$PORT -t ./
Instance Type: Free
```

### 3. Crear Base de Datos PostgreSQL
1. Click en **"New +"** → **"PostgreSQL"**
2. Configura:
```yaml
Name: tienda-virtual-db
Database Name: tienda_virtual
User: tienda_user
Region: (misma que el web service)
Instance Type: Free
```

### 4. Configurar Variables de Entorno
En tu Web Service → Settings → Environment Variables:

```bash
# Entorno
APP_ENV=production
BASE_URL=https://tu-app.onrender.com

# Base de Datos (Render proporciona estos valores)
DB_HOST=tu-host-de-render-db
DB_NAME=tienda_virtual
DB_USER=tu-usuario-de-render
DB_PASSWORD=tu-contraseña-de-render
DB_PORT=5432

# PayPal
PAYPAL_URL=https://api-m.paypal.com
PAYPAL_CLIENT_ID_PRIMARY=tu-client-id-paypal
PAYPAL_SECRET_PRIMARY=tu-secret-paypal

# Email
MAIL_DRIVER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_SECURE=tls
MAIL_USER=tu-email@gmail.com
MAIL_PASSWORD=tu-app-password
```

### 5. Migrar Base de Datos

#### Opción A: Via Dashboard Render
1. Ve a tu PostgreSQL service
2. Click en **"Query"**
3. Copia y pega el contenido de `migrate_postgresql.sql`
4. Click en **"Run"**

#### Opción B: Via CLI
```bash
# Obtener conexión externa
psql -h tu-host -U tu-usuario -d tienda_virtual

# Ejecutar script
\i migrate_postgresql.sql
```

### 6. Deploy Automático
Render hace deploy automático cuando haces push a GitHub:

```bash
git add .
git commit -m "feat: actualizar para producción en Render"
git push origin master
```

## 📁 Estructura del Proyecto para Render

```
tienda_virtual/
├── Config/
│   ├── Config.php              # Configuración principal
│   └── DatabaseRender.php      # Adaptador PostgreSQL
├── Controllers/                # Controladores MVC
├── Models/                     # Modelos de datos
├── Views/                      # Vistas HTML/PHP
├── Assets/                     # CSS, JS, imágenes
├── Helpers/                    # Funciones auxiliares
├── Libraries/                  # Librerías personalizadas
├── vendor/                     # Dependencias Composer
├── composer.json               # Dependencias PHP
├── .htaccess                   # Configuración Apache
├── render.yaml                 # Configuración Render
├── migrate_postgresql.sql      # Script de migración
└── index.php                   # Punto de entrada
```

## 🗄️ Adaptaciones MySQL → PostgreSQL

### Cambios Principales
1. **Tipos de datos**: `INT` → `SERIAL`, `VARCHAR` igual, `TEXT` igual
2. **Auto increment**: `AUTO_INCREMENT` → `SERIAL PRIMARY KEY`
3. **Timestamps**: `CURRENT_TIMESTAMP` → `CURRENT_TIMESTAMP` (igual)
4. **Índices**: Sintaxis similar con `CREATE INDEX`
5. **Triggers**: PostgreSQL usa PL/pgSQL

### Funciones de Conexión
```php
// MySQL (anterior)
$conn = new PDO("mysql:host=$host;dbname=$db", $user, $pass);

// PostgreSQL (Render)
$conn = new PDO("pgsql:host=$host;port=$port;dbname=$db", $user, $pass);
```

## 🔧 Desarrollo Local con PostgreSQL

### Instalar PostgreSQL Local
```bash
# Windows
# Descargar desde: https://www.postgresql.org/download/windows/

# Mac
brew install postgresql

# Linux
sudo apt-get install postgresql postgresql-contrib
```

### Configurar Local
```bash
# Crear base de datos
createdb tienda_virtual

# Crear usuario
createuser tienda_user

# Conectar y ejecutar migración
psql -d tienda_virtual -f migrate_postgresql.sql
```

## 📊 Monitoreo y Logs

Render proporciona:
- **Logs en tiempo real** en el Dashboard
- **Métricas de rendimiento**
- **Alertas automáticas**
- **Backups automáticos** de base de datos
- **Deploy history** completo

### Ver Logs
```bash
# Via Dashboard
Service → Logs

# Via CLI (si tienes)
render logs
```

## 🎯 Comandos Útiles

### Git y Deploy
```bash
# Deploy a producción
git push origin master

# Deploy a rama específica
git push origin develop

# Ver status del deploy
# (Ver Dashboard de Render)
```

### Base de Datos
```bash
# Conectar a base de datos remota
psql -h tu-host -U tu-usuario -d tienda_virtual

# Ver tablas
\dt

# Ver estructura de tabla
\d nombre_tabla

# Salir
\q
```

## 🔒 Seguridad en Render

### Configuración de Seguridad
- ✅ **SSL automático** en todos los planes
- ✅ **Firewall integrado**
- ✅ **Variables de entorno cifradas**
- ✅ **Conexiones seguras** a base de datos
- ✅ **Backups automáticos** encriptados

### Mejores Prácticas
1. **Usar variables de entorno** para datos sensibles
2. **Validar todas las entradas** de usuario
3. **Usar prepared statements** para consultas SQL
4. **Implementar rate limiting** en APIs
5. **Mantener dependencias actualizadas**

## 🆘 Troubleshooting Común

### Error 502: Bad Gateway
- **Causa**: Aplicación no inició correctamente
- **Solución**: Revisa logs, verifica variables de entorno

### Error de Base de Datos
- **Causa**: Credenciales incorrectas o BD no migrada
- **Solución**: Verifica variables de entorno, ejecuta migración

### Build Fallido
- **Causa**: Dependencias faltantes o error en composer
- **Solución**: Revisa composer.json, actualiza dependencias

### Upload de Archivos
- **Causa**: Permisos incorrectos o directorio no existe
- **Solución**: Crea directorios Assets/uploads/, configura permisos

## 📈 Escalabilidad

### Plan Free (Limites)
- **750 horas/mes** de compute
- **1 GB RAM**
- **512 MB almacenamiento**
- **Base de datos 256 MB**
- **Custom domain** con certificado SSL

### Plan Starter ($7/mes)
- **750 horas/mes** de compute
- **2 GB RAM**
- **10 GB almacenamiento**
- **Base de datos 5 GB**
- **Builds más rápidos**

### Plan Standard ($25/mes)
- **Todo lo de Starter +**
- **750 horas/mes** adicionales
- **4 GB RAM**
- **50 GB almacenamiento**
- **Base de datos 25 GB**

## ✅ Checklist Final de Despliegue

- [ ] Cuenta en Render creada
- [ ] Repositorio GitHub conectado
- [ ] Servicio Web PHP creado
- [ ] Base de datos PostgreSQL creada
- [ ] Variables de entorno configuradas
- [ ] Script de migración ejecutado
- [ ] Deploy exitoso completado
- [ ] Funcionalidad básica probada
- [ ] Dominio personalizado configurado (opcional)
- [ ] SSL verificado
- [ ] Backups automáticos confirmados

---

## 🎉 ¡Listo para Producción!

Tu Tienda Virtual PHP está ahora desplegada en Render con:

- ✅ **Alto rendimiento** con CDN global
- ✅ **Base de datos robusta** PostgreSQL
- ✅ **SSL gratuito** y seguridad integrada
- ✅ **Escalabilidad flexible** según crecimiento
- ✅ **Monitoreo continuo** y alertas
- ✅ **Deploys automáticos** desde GitHub

### Enlaces Útiles
- 📚 [Documentación Render PHP](https://render.com/docs/deploy-php-examples)
- 🎥 [Tutoriales Render](https://render.com/docs)
- 💬 [Comunidad Render Discord](https://discord.gg/render)
- 🆘 [Soporte Render](https://render.com/support)
