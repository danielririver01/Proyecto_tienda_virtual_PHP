-- Script de migración de MySQL a PostgreSQL para Tienda Virtual
-- Ejecutar este script en tu base de datos PostgreSQL de Render

-- 1. Crear extensiones necesarias
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. Crear tabla usuarios (adaptada para PostgreSQL)
CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    idrol INTEGER DEFAULT 3,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    status INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Crear tabla clientes
CREATE TABLE IF NOT EXISTS clientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT,
    nit VARCHAR(20),
    status INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Crear tabla categorías
CREATE TABLE IF NOT EXISTS categorias (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    portada VARCHAR(255),
    status INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Crear tabla productos
CREATE TABLE IF NOT EXISTS productos (
    id SERIAL PRIMARY KEY,
    categoria_id INTEGER REFERENCES categorias(id),
    nombre VARCHAR(200) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    stock INTEGER DEFAULT 0,
    imagen VARCHAR(255),
    status INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 6. Crear tabla pedidos
CREATE TABLE IF NOT EXISTS pedidos (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES clientes(id),
    monto DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) DEFAULT 'Pendiente',
    transaccion_paypal VARCHAR(255),
    transaccion_mp VARCHAR(255),
    direccion_envio TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 7. Crear tabla detalle_pedido
CREATE TABLE IF NOT EXISTS detalle_pedido (
    id SERIAL PRIMARY KEY,
    pedido_id INTEGER REFERENCES pedidos(id),
    producto_id INTEGER REFERENCES productos(id),
    precio DECIMAL(10,2) NOT NULL,
    cantidad INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 8. Crear tabla carrito
CREATE TABLE IF NOT EXISTS carrito (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES clientes(id),
    producto_id INTEGER REFERENCES productos(id),
    precio DECIMAL(10,2) NOT NULL,
    cantidad INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 9. Crear tabla contactos
CREATE TABLE IF NOT EXISTS contactos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    mensaje TEXT NOT NULL,
    status INTEGER DEFAULT 1,
    leido INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 10. Crear tabla suscriptores
CREATE TABLE IF NOT EXISTS suscriptores (
    id SERIAL PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    status INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 11. Crear tabla roles
CREATE TABLE IF NOT EXISTS roles (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,
    status INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 12. Crear tabla permisos
CREATE TABLE IF NOT EXISTS permisos (
    id SERIAL PRIMARY KEY,
    rol_id INTEGER REFERENCES roles(id),
    modulo VARCHAR(50) NOT NULL,
    vista VARCHAR(50) NOT NULL,
    acceso INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 13. Insertar datos básicos
INSERT INTO roles (id, nombre, descripcion) VALUES 
(1, 'Administrador', 'Acceso completo al sistema'),
(2, 'Supervisor', 'Acceso limitado a funciones administrativas'),
(3, 'Cliente', 'Acceso solo a funciones de cliente')
ON CONFLICT (id) DO NOTHING;

-- 14. Insertar permisos básicos
INSERT INTO permisos (rol_id, modulo, vista, acceso) VALUES 
(1, 'dashboard', 'index', 1),
(1, 'usuarios', 'index', 1),
(1, 'usuarios', 'crear', 1),
(1, 'clientes', 'index', 1),
(1, 'productos', 'index', 1),
(1, 'productos', 'crear', 1),
(1, 'pedidos', 'index', 1),
(1, 'categorias', 'index', 1),
(2, 'dashboard', 'index', 1),
(2, 'pedidos', 'index', 1),
(2, 'clientes', 'index', 1),
(3, 'tienda', 'index', 1),
(3, 'carrito', 'index', 1)
ON CONFLICT DO NOTHING;

-- 15. Insertar categorías básicas
INSERT INTO categorias (nombre, descripcion) VALUES 
('Ropa Hombre', 'Ropa y accesorios para hombres'),
('Ropa Mujer', 'Ropa y accesorios para mujeres'),
('Electrónica', 'Dispositivos electrónicos y gadgets'),
('Hogar', 'Artículos para el hogar'),
('Deportes', 'Equipamiento deportivo')
ON CONFLICT DO NOTHING;

-- 16. Crear índices para mejor rendimiento
CREATE INDEX IF NOT EXISTS idx_usuarios_email ON usuarios(email);
CREATE INDEX IF NOT EXISTS idx_clientes_email ON clientes(email);
CREATE INDEX IF NOT EXISTS idx_productos_categoria ON productos(categoria_id);
CREATE INDEX IF NOT EXISTS idx_productos_status ON productos(status);
CREATE INDEX IF NOT EXISTS idx_pedidos_cliente ON pedidos(cliente_id);
CREATE INDEX IF NOT EXISTS idx_pedidos_status ON pedidos(status);
CREATE INDEX IF NOT EXISTS idx_carrito_cliente ON carrito(cliente_id);

-- 17. Crear función para actualizar timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- 18. Crear triggers para actualizar updated_at
CREATE TRIGGER update_usuarios_updated_at BEFORE UPDATE ON usuarios
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_clientes_updated_at BEFORE UPDATE ON clientes
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_categorias_updated_at BEFORE UPDATE ON categorias
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_productos_updated_at BEFORE UPDATE ON productos
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_pedidos_updated_at BEFORE UPDATE ON pedidos
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- 19. Crear usuario administrador por defecto
INSERT INTO usuarios (idrol, nombre, apellido, email, password, telefono) VALUES 
(1, 'Admin', 'Tienda', 'admin@tienda.com', '21232f297a57a5a743894a0e4a801fc3', '123456789')
ON CONFLICT (email) DO NOTHING;

-- 20. Verificación final
SELECT 'Base de datos PostgreSQL para Tienda Virtual creada exitosamente' as mensaje;
SELECT COUNT(*) as total_categorias FROM categorias;
SELECT COUNT(*) as total_roles FROM roles;
SELECT COUNT(*) as total_permisos FROM permisos;
