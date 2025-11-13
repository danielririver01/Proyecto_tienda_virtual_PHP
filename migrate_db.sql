-- Script para exportar/importar base de datos de la Tienda Virtual
-- Ejecutar estos comandos en tu terminal local

-- 1. EXPORTAR BASE DE DATOS LOCAL
-- =================================
-- mysqldump -u root -p db_tiendavirtual > tienda_virtual_export.sql

-- 2. IMPORTAR A HEROKU (después del deploy)
-- ==========================================
-- Obtener credenciales: heroku config:get JAWSDB_URL --app tu-app-name
-- mysql -h host -u usuario -p base_de_datos < tienda_virtual_export.sql

-- 3. VERIFICAR TABLAS ESPERADAS
-- =============================
-- Las tablas principales que deberían existir:

SHOW TABLES;

-- Tablas esperadas:
-- usuarios
-- clientes  
-- productos
-- categorias
-- pedidos
-- detalle_pedido
-- carrito
-- contactos
-- suscriptores
-- roles
-- permisos

-- 4. VERIFICAR DATOS IMPORTANTES
-- ==============================
SELECT COUNT(*) as total_usuarios FROM usuarios;
SELECT COUNT(*) as total_clientes FROM clientes;
SELECT COUNT(*) as total_productos FROM productos;
SELECT COUNT(*) as total_categorias FROM categorias;
SELECT COUNT(*) as total_pedidos FROM pedidos;

-- 5. CONFIGURAR ADMINISTRADOR POR DEFECTO (si no existe)
-- =======================================================
-- INSERT INTO usuarios (idrol, nombre, apellido, email, password, telefono, status, created_at) 
-- VALUES (1, 'Admin', 'Tienda', 'admin@tienda.com', '21232f297a57a5a743894a0e4a801fc3', '123456789', 1, NOW());
-- Nota: Contraseña por defecto: 'admin' (hash MD5)

-- 6. LIMPIAR DATOS DE PRUEBA (opcional)
-- =====================================
-- DELETE FROM carrito WHERE fecha < DATE_SUB(NOW(), INTERVAL 30 DAY);
-- DELETE FROM pedidos WHERE status = 'Cancelado' AND fecha < DATE_SUB(NOW(), INTERVAL 90 DAY);
