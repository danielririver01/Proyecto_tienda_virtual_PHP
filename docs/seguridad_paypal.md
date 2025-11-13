# Guía de configuración segura de PayPal

## Objetivo
Proteger credenciales de la API de PayPal (client_id, secret, endpoints) y asegurar conexiones HTTPS, evitando exposición en errores, logs o respuestas.

## 1. Variables en `.env`
Ubicación: `c:\xampp\htdocs\tienda_virtual\.env`

Contenido recomendado:

```
PAYPAL_ENV=sandbox
PAYPAL_URL=https://api-m.sandbox.paypal.com
PAYPAL_KEY_ACTIVE=primary
PAYPAL_CLIENT_ID_primary="<client_id_sandbox>"
PAYPAL_SECRET_primary="<secret_sandbox>"
PAYPAL_CLIENT_ID_backup=""
PAYPAL_SECRET_backup=""
```

- `PAYPAL_KEY_ACTIVE`: controla qué par de credenciales se usa.
- `PAYPAL_URL`: siempre debe comenzar con `https://`.

## 2. Bloqueo de acceso público
Archivo: `c:\xampp\htdocs\tienda_virtual\.htaccess`

Se incluye restricción de acceso:

```
<Files ".env">
  Require all denied
</Files>

RewriteRule ^\.env - [F,L]
```

## 3. Carga segura en `Config.php`
Archivo: `c:\xampp\htdocs\tienda_virtual\Config\Config.php`

- Se cargan variables desde `.env` usando `parse_ini_file`.
- Se definen constantes: `URLPAYPAL`, `IDCLIENTE`, `SECRET`.
- Se fuerza el uso de `https://` en `URLPAYPAL`.

## 4. Conexiones HTTPS y verificación TLS
Archivo: `c:\xampp\htdocs\tienda_virtual\Helpers\Helpers.php`

- Se activa `CURLOPT_SSL_VERIFYPEER = TRUE` y `CURLOPT_SSL_VERIFYHOST = 2` en llamadas `cURL`.
- Se garantiza que las URLs hacia PayPal usen `https://`.

## 5. No exponer credenciales
- No se registran valores de `SECRET` ni `IDCLIENTE` en logs o respuestas.
- El `client_id` puede aparecer en el tag del SDK de PayPal por requisitos del servicio; el `secret` jamás se expone.

## 6. Rotación de credenciales
- Mantener dos pares `primary` y `backup` en `.env`.
- Para rotar: actualizar `PAYPAL_CLIENT_ID_backup`/`PAYPAL_SECRET_backup` y cambiar `PAYPAL_KEY_ACTIVE=backup`.
- Reiniciar el servidor si es necesario para recargar variables.

## 7. Comprobación rápida
- Validar sintaxis: `C:\xampp\php\php.exe -l c:\xampp\htdocs\tienda_virtual\Config\Config.php`
- Probar flujo de pago en sandbox verificando que la URL del SDK usa `client-id` correcto y que las llamadas del backend responden sin errores TLS.

## 8. Producción
- Cambiar `PAYPAL_ENV=live` y `PAYPAL_URL=https://api-m.paypal.com`.
- Configurar credenciales live en `primary` o `backup` según política de rotación.

# Seguridad de credenciales de Base de Datos

## Variables en `.env`
```
APP_ENV=production
APP_SECURE_SECRETS=1
APP_SECRET_KEY="<clave-32-bytes>"
APP_SECRET_IV="<iv-16-bytes>"
DB_HOST=<host>
DB_NAME=<nombre>
DB_USER=<usuario>
DB_PASSWORD_ENC="<base64 aes-256-cbc del password>"
DB_CHARSET=utf8mb4
```

## Carga y validación en `Config/Config.php`
- Se leen y validan variables requeridas.
- En producción se usa `DB_PASSWORD_ENC` con desencriptado OpenSSL.
- Si falta una variable crítica, se detiene la ejecución con mensaje controlado.

## Alternativa con archivo protegido
- Ubicar archivo de configuración fuera del DocumentRoot.
- Aplicar ACL restrictivas en Windows (equivalente a `chmod 600`).
- Excluir de Git.
- Permitir contenidos encriptados y desencriptar en runtime.

# Contraseñas de usuarios
## Algoritmo y parámetros
- Preferir `Argon2id`; fallback `bcrypt`.
- Desarrollo: cost moderado; Producción: coste incrementado.

## Migración transparente
- Detección automática de SHA-256 o texto plano en login.
- Rehash automático al verificar éxito.
- Registro de auditoría en `storage/logs/security.log`.

## Validación de fortaleza
- Mínimo 10 caracteres, mayúsculas, números, lista negra.
- Feedback claro al usuario.
