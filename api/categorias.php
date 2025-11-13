<?php
// API Endpoint para Categorías - Vercel Function
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

require_once __DIR__ . '/../Config/Config.php';

try {
    $conn = new PDO("mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=" . DB_CHARSET, DB_USER, DB_PASSWORD);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    echo json_encode(['error' => 'Error de conexión: ' . $e->getMessage()]);
    exit;
}

$method = $_SERVER['REQUEST_METHOD'];

switch($method) {
    case 'GET':
        getCategorias($conn);
        break;
    case 'POST':
        crearCategoria($conn);
        break;
    default:
        echo json_encode(['error' => 'Método no permitido']);
        break;
}

function getCategorias($conn) {
    $sql = "SELECT * FROM categorias WHERE status = 1 ORDER BY nombre";
    
    try {
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $categorias = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        echo json_encode([
            'success' => true,
            'data' => $categorias,
            'total' => count($categorias)
        ]);
    } catch(PDOException $e) {
        echo json_encode(['error' => 'Error al obtener categorías: ' . $e->getMessage()]);
    }
}

function crearCategoria($conn) {
    $data = json_decode(file_get_contents('php://input'), true);
    
    if (!$data || empty($data['nombre'])) {
        echo json_encode(['error' => 'El nombre de la categoría es requerido']);
        return;
    }
    
    try {
        $sql = "INSERT INTO categorias (nombre, descripcion, status, created_at) 
                VALUES (?, ?, 1, NOW())";
        
        $stmt = $conn->prepare($sql);
        $stmt->execute([
            $data['nombre'],
            $data['descripcion'] ?? ''
        ]);
        
        echo json_encode([
            'success' => true,
            'message' => 'Categoría creada exitosamente',
            'id' => $conn->lastInsertId()
        ]);
    } catch(PDOException $e) {
        echo json_encode(['error' => 'Error al crear categoría: ' . $e->getMessage()]);
    }
}
?>
