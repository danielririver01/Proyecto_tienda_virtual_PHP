<?php
// API Endpoint para Productos - Vercel Function
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

// Cargar configuración
require_once __DIR__ . '/../Config/Config.php';

// Conexión a base de datos
try {
    $conn = new PDO("mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=" . DB_CHARSET, DB_USER, DB_PASSWORD);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    echo json_encode(['error' => 'Error de conexión: ' . $e->getMessage()]);
    exit;
}

// Método HTTP
$method = $_SERVER['REQUEST_METHOD'];

switch($method) {
    case 'GET':
        getProductos($conn);
        break;
    case 'POST':
        crearProducto($conn);
        break;
    default:
        echo json_encode(['error' => 'Método no permitido']);
        break;
}

function getProductos($conn) {
    $categoria_id = $_GET['categoria'] ?? null;
    $search = $_GET['search'] ?? null;
    
    $sql = "SELECT p.*, c.nombre as categoria_nombre 
            FROM productos p 
            LEFT JOIN categorias c ON p.categoria_id = c.id 
            WHERE p.status = 1";
    
    $params = [];
    
    if ($categoria_id) {
        $sql .= " AND p.categoria_id = ?";
        $params[] = $categoria_id;
    }
    
    if ($search) {
        $sql .= " AND (p.nombre LIKE ? OR p.descripcion LIKE ?)";
        $searchTerm = "%$search%";
        $params[] = $searchTerm;
        $params[] = $searchTerm;
    }
    
    $sql .= " ORDER BY p.created_at DESC";
    
    try {
        $stmt = $conn->prepare($sql);
        $stmt->execute($params);
        $productos = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        // Formatear precios y URLs
        foreach ($productos as &$producto) {
            $producto['precio'] = number_format($producto['precio'], 2);
            $producto['imagen'] = BASE_URL . '/Assets/tienda/images/' . $producto['imagen'];
        }
        
        echo json_encode([
            'success' => true,
            'data' => $productos,
            'total' => count($productos)
        ]);
    } catch(PDOException $e) {
        echo json_encode(['error' => 'Error al obtener productos: ' . $e->getMessage()]);
    }
}

function crearProducto($conn) {
    $data = json_decode(file_get_contents('php://input'), true);
    
    if (!$data) {
        echo json_encode(['error' => 'Datos no válidos']);
        return;
    }
    
    // Validar campos requeridos
    $required = ['nombre', 'descripcion', 'precio', 'categoria_id', 'stock'];
    foreach ($required as $field) {
        if (empty($data[$field])) {
            echo json_encode(['error' => "El campo $field es requerido"]);
            return;
        }
    }
    
    try {
        $sql = "INSERT INTO productos (nombre, descripcion, precio, categoria_id, stock, status, created_at) 
                VALUES (?, ?, ?, ?, ?, 1, NOW())";
        
        $stmt = $conn->prepare($sql);
        $stmt->execute([
            $data['nombre'],
            $data['descripcion'],
            $data['precio'],
            $data['categoria_id'],
            $data['stock']
        ]);
        
        echo json_encode([
            'success' => true,
            'message' => 'Producto creado exitosamente',
            'id' => $conn->lastInsertId()
        ]);
    } catch(PDOException $e) {
        echo json_encode(['error' => 'Error al crear producto: ' . $e->getMessage()]);
    }
}
?>
