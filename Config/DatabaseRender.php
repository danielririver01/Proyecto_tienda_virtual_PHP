<?php
// Configuración de base de datos para Render (PostgreSQL)
class DatabaseRender {
    private static $instance = null;
    private $connection;
    
    private function __construct() {
        try {
            // Obtener variables de entorno de Render
            $dbHost = getenv('DB_HOST') ?: 'localhost';
            $dbName = getenv('DB_NAME') ?: 'tienda_virtual';
            $dbUser = getenv('DB_USER') ?: 'tienda_user';
            $dbPassword = getenv('DB_PASSWORD') ?: '';
            $dbPort = getenv('DB_PORT') ?: '5432';
            
            // Conexión PostgreSQL
            $dsn = "pgsql:host={$dbHost};port={$dbPort};dbname={$dbName}";
            
            $this->connection = new PDO($dsn, $dbUser, $dbPassword);
            $this->connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $this->connection->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
            
        } catch(PDOException $e) {
            die('Error de conexión a PostgreSQL: ' . $e->getMessage());
        }
    }
    
    public static function getInstance() {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }
    
    public function getConnection() {
        return $this->connection;
    }
    
    // Método para ejecutar consultas con compatibilidad MySQL
    public function query($sql, $params = []) {
        try {
            $stmt = $this->connection->prepare($sql);
            $stmt->execute($params);
            return $stmt;
        } catch(PDOException $e) {
            throw new Exception('Error en consulta: ' . $e->getMessage());
        }
    }
    
    // Método para obtener último ID (PostgreSQL)
    public function lastInsertId($sequence = null) {
        return $this->connection->lastInsertId($sequence);
    }
}

// Función global para compatibilidad con código existente
function getDBConnection() {
    return DatabaseRender::getInstance()->getConnection();
}
?>
