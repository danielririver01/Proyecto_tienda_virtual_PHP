@echo off
chcp 65001 >nul
REM Script de despliegue para Render - Tienda Virtual PHP

echo Iniciando despliegue en Render...

REM Verificar si Git esta instalado
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Git no esta instalado. Por favor instálalo desde https://git-scm.com/
    pause
    exit /b 1
)

REM Verificar si estamos en un repositorio Git
git rev-parse --git-dir >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: No estas en un repositorio Git
    echo Ejecuta: git init
    pause
    exit /b 1
)

REM Hacer commit de cambios pendientes
echo Haciendo commit de cambios para Render...
git add .
git commit -m "feat(deploy): configurar para despliegue en Render"

REM Verificar si tenemos remote de Render
git remote get-url render >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Configurando remote de Render...
    git remote add render https://git.render.com/tu-repo.git
    echo.
    echo IMPORTANTE: Reemplaza 'tu-repo.git' con tu repositorio real de Render
    echo.
    pause
)

REM Hacer push a Render
echo Desplegando aplicacion en Render...
git push render master

echo.
echo Despliegue iniciado en Render!
echo.
echo Proximos pasos:
echo 1. Ve a https://dashboard.render.com/
echo 2. Espera a que termine el build
echo 3. Configura las variables de entorno
echo 4. Ejecuta el script de migracion PostgreSQL
echo.
echo Variables de entorno requeridas en Render:
echo - APP_ENV=production
echo - BASE_URL=https://tu-app.onrender.com
echo - DB_HOST (proporcionado por Render)
echo - DB_NAME=tienda_virtual
echo - DB_USER (proporcionado por Render)
echo - DB_PASSWORD (proporcionado por Render)
echo - DB_PORT=5432
echo.
echo - PAYPAL_CLIENT_ID_PRIMARY
echo - PAYPAL_SECRET_PRIMARY
echo - MAIL_HOST
echo - MAIL_USER
echo - MAIL_PASSWORD
echo.
echo Para ejecutar migracion de base de datos:
echo 1. Ve a PostgreSQL Dashboard en Render
echo 2. Click en "Query"
echo 3. Copia y pega el contenido de migrate_postgresql.sql
echo 4. Ejecuta el script

pause
