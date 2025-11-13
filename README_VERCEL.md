# 🚀 Guía de Despliegue en Vercel - Tienda Virtual PHP

## 📋 Resumen

Vercel es una excelente opción para hosting gratuito con algunas adaptaciones para PHP. Esta guía te ayudará a desplegar tu tienda virtual en Vercel.

## 🏗️ Arquitectura Adaptada

### Frontend (Estático)
- HTML, CSS, JavaScript
- Assets públicos (imágenes, fuentes)
- Vistas PHP renderizadas estáticamente

### Backend (Serverless Functions)
- API endpoints en `/api/`
- Autenticación
- Gestión de productos y categorías
- Procesamiento de pedidos

### Base de Datos (Externa)
- **PlanetScale** (Recomendado)
- **Supabase**
- **Neon**
- **Railway**

## 🚀 Pasos de Despliegue

### 1. Instalar Vercel CLI
```bash
npm install -g vercel
```

### 2. Ejecutar Script de Despliegue
```bash
deploy_vercel.bat
```

### 3. Configurar Base de Datos

#### Opción A: PlanetScale (Recomendado)
```bash
# 1. Crear cuenta en https://planetscale.com/
# 2. Crear nueva base de datos
# 3. Obtener credenciales
# 4. Configurar en Vercel Dashboard
```

#### Opción B: Supabase
```bash
# 1. Crear cuenta en https://supabase.com/
# 2. Crear nuevo proyecto
# 3. Obtener URL de conexión
# 4. Configurar variables de entorno
```

### 4. Variables de Entorno en Vercel

Configura estas variables en el Dashboard de Vercel:

```bash
# Entorno
APP_ENV=production
BASE_URL=https://tu-app.vercel.app

# Base de datos (PlanetScale ejemplo)
DB_HOST=aws.connect.psdb.cloud
DB_NAME=tu_database
DB_USER=tu_usuario
DB_PASSWORD=tu_contraseña
DB_CHARSET=utf8mb4

# PayPal
PAYPAL_URL=https://api-m.paypal.com
PAYPAL_CLIENT_ID_PRIMARY=tu_client_id
PAYPAL_SECRET_PRIMARY=tu_secret

# Email
MAIL_DRIVER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_SECURE=tls
MAIL_USER=tu_email@gmail.com
MAIL_PASSWORD=tu_app_password
```

## 📁 Estructura para Vercel

```
tienda_virtual/
├── api/                    # Serverless Functions
│   ├── auth.php           # Autenticación
│   ├── productos.php      # Gestión de productos
│   ├── categorias.php     # Gestión de categorías
│   └── index.php          # API principal
├── Assets/                # Archivos estáticos
├── Views/                 # Vistas HTML/PHP
├── Config/                # Configuración
├── Models/                # Modelos de datos
├── Controllers/           # Controladores (limitado)
├── vercel.json           # Configuración de Vercel
├── package.json          # Dependencias Node.js
├── composer.json         # Dependencias PHP
└── index.php             # Punto de entrada
```

## 🔌 API Endpoints

### Autenticación
```bash
POST /api/auth?action=login
POST /api/auth?action=register
POST /api/auth?action=logout
```

### Productos
```bash
GET  /api/productos
GET  /api/productos?categoria=1
GET  /api/productos?search=telefono
POST /api/productos
```

### Categorías
```bash
GET  /api/categorias
POST /api/categorias
```

## 🗄️ Migración de Base de Datos

### Exportar Base de Datos Local
```bash
mysqldump -u root -p db_tiendavirtual > tienda_local.sql
```

### Importar a PlanetScale
```bash
# Usar CLI de PlanetScale
pscale shell tu_database main
source tienda_local.sql
```

### Estructura de Tablas Requeridas
```sql
-- Usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    idrol INT,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255),
    telefono VARCHAR(20),
    status INT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Clientes
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    telefono VARCHAR(20),
    direccion TEXT,
    status INT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Productos
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    categoria_id INT,
    nombre VARCHAR(200),
    descripcion TEXT,
    precio DECIMAL(10,2),
    stock INT,
    imagen VARCHAR(255),
    status INT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Categorías
CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT,
    status INT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Pedidos
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    total DECIMAL(10,2),
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## 🎯 Limitaciones y Soluciones

### Limitaciones de Vercel para PHP
- ❌ No hay sistema de archivos persistente
- ❌ Sesiones limitadas a 10MB
- ❌ No hay ejecución de procesos largos
- ❌ Base de datos no incluida

### Soluciones Implementadas
- ✅ Serverless Functions para backend
- ✅ Base de datos externa (PlanetScale)
- ✅ JWT para autenticación sin sesiones
- ✅ Assets servidos estáticamente
- ✅ Cache optimizado

## 🔧 Desarrollo Local

### Iniciar Servidor Local
```bash
vercel dev
```

### Probar API Endpoints
```bash
# Productos
curl http://localhost:3000/api/productos

# Login
curl -X POST http://localhost:3000/api/auth?action=login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"123456"}'
```

## 📊 Monitoreo y Logs

Vercel proporciona:
- **Logs en tiempo real** en el Dashboard
- **Analytics** de uso y rendimiento
- **Deploy previews** para cada PR
- **Rollback automático** en caso de error

## 🚀 Comandos Útiles

```bash
# Deploy a producción
vercel --prod

# Deploy a preview
vercel

# Ver logs
vercel logs

# Ver configuración
vercel env ls

# Agregar variable de entorno
vercel env add DB_PASSWORD
```

## 🆘 Soporte y Troubleshooting

### Problemas Comunes
1. **Error 502**: Revisa variables de entorno
2. **Timeout**: Optimiza consultas a BD
3. **Memory limit**: Reduce tamaño de responses

### Recursos
- 📚 [Documentación Vercel PHP](https://vercel.com/docs/concepts/functions/serverless-functions/runtimes/php)
- 🎥 [Tutoriales Vercel](https://vercel.com/guides)
- 💬 [Comunidad Vercel](https://vercel.com/discord)

---

## ✅ Checklist Final de Despliegue

- [ ] Instalar Vercel CLI
- [ ] Configurar base de datos externa
- [ ] Configurar variables de entorno
- [ ] Migrar datos a nueva base de datos
- [ ] Probar API endpoints
- [ ] Verificar frontend estático
- [ ] Configurar dominio personalizado (opcional)
- [ ] Configurar SSL (automático en Vercel)
- [ ] Monitorear primeros días de producción
