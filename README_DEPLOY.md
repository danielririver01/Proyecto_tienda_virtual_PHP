# 🚀 Guía de Despliegue - Tienda Virtual PHP

## ⚠️ ADVERTENCIA IMPORTANTE

**Vercel no es la plataforma ideal para aplicaciones PHP MVC tradicionales** como la actual. Vercel está optimizado para aplicaciones JavaScript/Node.js.

## 📋 Opciones Recomendadas

### 1. Heroku (Recomendado) ⭐
```bash
# Instalar Heroku CLI
# Crear app en Heroku
heroku create tu-tienda-virtual

# Configurar variables de entorno
heroku config:set APP_ENV=production
heroku config:set DB_HOST=tu-db-host
heroku config:set DB_NAME=tu-db-name
heroku config:set DB_USER=tu-db-user
heroku config:set DB_PASSWORD=tu-db-password

# Hacer deploy
git push heroku master
```

### 2. DigitalOcean App Platform
```bash
# Subir a repositorio Git
# Conectar a DigitalOcean
# Configurar variables de entorno
# Desplegar automáticamente
```

### 3. AWS Elastic Beanstalk
```bash
# Usar CLI de AWS
# Crear aplicación PHP
# Configurar entorno RDS MySQL
# Desplegar aplicación
```

## 🔧 Configuración para Vercel (Limitada)

Si aún deseas intentar Vercel, la configuración está preparada pero con limitaciones:

### Variables de Entorno Requeridas en Vercel:
```
APP_ENV=production
DB_HOST=tu-host-de-base-de-datos
DB_NAME=tu-base-de-datos
DB_USER=tu-usuario
DB_PASSWORD=tu-contraseña
PAYPAL_CLIENT_ID_PRIMARY=tu-client-id
PAYPAL_SECRET_PRIMARY=tu-secret
MAIL_HOST=tu-smtp-host
MAIL_PORT=587
MAIL_USER=tu-email
MAIL_PASSWORD=tu-email-password
```

### Limitaciones en Vercel:
- ❌ No hay base de datos MySQL nativa
- ❌ Sistema de archivos limitado
- ❌ Funciones serverless solo para endpoints específicos
- ❌ Sesiones limitadas
- ❌ Subida de archivos restringida

## 🗂️ Estructura Preparada

```
tienda_virtual/
├── api/                 # Endpoints para Vercel Functions
├── vercel.json          # Configuración de Vercel
├── package.json         # Dependencias Node.js
├── composer.json        # Dependencias PHP
├── Procfile            # Configuración Heroku
├── .htaccess           # Configuración Apache
└── ...                 # Tu código existente
```

## 📝 Pasos para Despliegue en Heroku

1. **Crear cuenta en Heroku**
2. **Instalar Heroku CLI**
3. **Login**: `heroku login`
4. **Crear app**: `heroku create tu-tienda-virtual`
5. **Add-on MySQL**: `heroku addons:create jawsdb`
6. **Configurar variables de entorno**
7. **Hacer deploy**: `git push heroku master`

## 🔄 Migración de Base de Datos

```sql
-- Exportar base de datos local
mysqldump -u root -p db_tiendavirtual > tienda_virtual.sql

-- Importar en producción
mysql -h host -u user -p database < tienda_virtual.sql
```

## 🌐 Configuración de Dominio

Una vez desplegado, actualiza `Config/Config.php`:
```php
const BASE_URL = "https://tu-dominio-en-heroku.com";
```

## 📞 Soporte

Para ayuda con el despliegue:
- Heroku: https://devcenter.heroku.com/
- DigitalOcean: https://docs.digitalocean.com/
- AWS: https://docs.aws.amazon.com/elasticbeanstalk/
