# 🛍️ Tienda Virtual PHP

Sistema de e-commerce completo desarrollado en PHP con arquitectura MVC, integración con PayPal y MercadoPago.

## 🚀 Despliegue Rápido en Heroku

### Requisitos Previos
- Git instalado
- Heroku CLI instalado
- Cuenta en Heroku

### Pasos para Despliegue

1. **Clonar el repositorio**
```bash
git clone https://github.com/danielririver01/Proyecto_tienda_virtual_PHP.git
cd Proyecto_tienda_virtual_PHP
```

2. **Ejecutar script de despliegue**
```bash
# Windows
deploy.bat

# Linux/Mac
chmod +x deploy.sh
./deploy.sh
```

3. **Configurar variables de entorno adicionales**
```bash
# Reemplaza 'tu-app-name' con el nombre real de tu app
heroku config:set PAYPAL_CLIENT_ID_PRIMARY=tu-client-id --app tu-app-name
heroku config:set PAYPAL_SECRET_PRIMARY=tu-secret --app tu-app-name
heroku config:set MAIL_HOST=tu-smtp-host --app tu-app-name
heroku config:set MAIL_USER=tu-email --app tu-app-name
heroku config:set MAIL_PASSWORD=tu-password --app tu-app-name
```

4. **Migrar base de datos**
```bash
# Exportar base de datos local
mysqldump -u root -p db_tiendavirtual > tienda_virtual.sql

# Obtener credenciales de Heroku
heroku config:get JAWSDB_URL --app tu-app-name

# Importar a Heroku
mysql -h host -u usuario -p base_de_datos < tienda_virtual.sql
```

## 📋 Características

- 🛒 **Carrito de compras** con gestión de productos
- 💳 **Pasarelas de pago**: PayPal y MercadoPago
- 👥 **Gestión de usuarios** con roles y permisos
- 📧 **Sistema de notificaciones** por email
- 📊 **Panel administrativo** completo
- 📱 **Diseño responsive** para todos los dispositivos
- 🔐 **Autenticación segura** con encriptación
- 📈 **Reportes y estadísticas** de ventas

## 🗂️ Estructura del Proyecto

```
tienda_virtual/
├── Controllers/          # Controladores MVC
├── Models/              # Modelos de datos
├── Views/               # Vistas HTML/PHP
├── Assets/              # CSS, JS, imágenes
├── Config/              # Configuración principal
├── Helpers/             # Funciones auxiliares
├── Libraries/           # Librerías personalizadas
├── vendor/              # Dependencias Composer
├── Procfile            # Configuración Heroku
├── composer.json       # Dependencias PHP
├── .htaccess           # Configuración Apache
└── index.php           # Punto de entrada
```

## 🔧 Configuración Local

### Requisitos
- PHP 8.0+
- MySQL 5.7+
- Apache/Nginx
- Composer

### Instalación
```bash
# Clonar repositorio
git clone https://github.com/danielririver01/Proyecto_tienda_virtual_PHP.git
cd Proyecto_tienda_virtual_PHP

# Instalar dependencias
composer install

# Configurar base de datos
# 1. Crear base de datos: db_tiendavirtual
# 2. Importar estructura SQL
# 3. Configurar .env con credenciales

# Configurar servidor web
# Asegurar que DocumentRoot apunte a la raíz del proyecto
```

## 📊 Variables de Entorno

```bash
# Entorno
APP_ENV=production
BASE_URL=https://tu-app.herokuapp.com

# Base de datos (Heroku JawsDB)
DB_HOST=tu-host
DB_NAME=tu-base-de-datos
DB_USER=tu-usuario
DB_PASSWORD=tu-contraseña
DB_CHARSET=utf8mb4

# PayPal
PAYPAL_URL=https://api-m.paypal.com
PAYPAL_CLIENT_ID_PRIMARY=tu-client-id
PAYPAL_SECRET_PRIMARY=tu-secret

# Email
MAIL_DRIVER=smtp
MAIL_HOST=tu-smtp-host
MAIL_PORT=587
MAIL_SECURE=tls
MAIL_USER=tu-email
MAIL_PASSWORD=tu-password
```

## 🎯 Funcionalidades Principales

### Cliente
- 🛍️ Navegación de productos por categorías
- 🔍 Búsqueda avanzada de productos
- 🛒 Gestión del carrito de compras
- 👤 Perfil de usuario y historial de pedidos
- 💳 Proceso de checkout seguro
- 📧 Confirmación de pedidos por email

### Administrador
- 📊 Dashboard con estadísticas en tiempo real
- 👥 Gestión de usuarios y clientes
- 📦 Gestión completa de productos
- 🏷️ Gestión de categorías
- 📋 Gestión de pedidos y estados
- 📧 Gestión de contactos y suscriptores
- 🔐 Gestión de roles y permisos
- 📈 Reportes de ventas y productos

## 🔐 Seguridad

- 🔒 Encriptación de contraseñas con MD5 (actualizar a bcrypt)
- 🛡️ Protección contra inyección SQL
- 🔐 Validación de datos de entrada
- 🚫 Bloqueo de acceso a archivos sensibles
- 📋 Registro de actividades del sistema

## 📞 Soporte

- 📧 Email: info@abelosh.com
- 📞 Teléfono: +(502)78787845
- 💬 WhatsApp: +50278787845

## 📝 Licencia

Este proyecto es propiedad de Tienda Virtual © 2024

---

## 🚀 Deploy en Producción

Para despliegue en producción, sigue la guía completa en `README_DEPLOY.md`
