<?php
// API Endpoint para Autenticación - Vercel Function
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
    case 'POST':
        $action = $_GET['action'] ?? '';
        switch($action) {
            case 'login':
                login($conn);
                break;
            case 'register':
                register($conn);
                break;
            case 'logout':
                logout();
                break;
            default:
                echo json_encode(['error' => 'Acción no válida']);
                break;
        }
        break;
    default:
        echo json_encode(['error' => 'Método no permitido']);
        break;
}

function login($conn) {
    $data = json_decode(file_get_contents('php://input'), true);
    
    if (!$data || empty($data['email']) || empty($data['password'])) {
        echo json_encode(['error' => 'Email y contraseña son requeridos']);
        return;
    }
    
    try {
        $sql = "SELECT u.*, r.nombre as rol_nombre 
                FROM usuarios u 
                LEFT JOIN roles r ON u.idrol = r.id 
                WHERE u.email = ? AND u.status = 1";
        
        $stmt = $conn->prepare($sql);
        $stmt->execute([$data['email']]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if ($user && md5($data['password']) === $user['password']) {
            // Eliminar contraseña del response
            unset($user['password']);
            
            // Generar token simple (en producción usar JWT)
            $token = bin2hex(random_bytes(32));
            
            echo json_encode([
                'success' => true,
                'message' => 'Login exitoso',
                'user' => $user,
                'token' => $token
            ]);
        } else {
            echo json_encode(['error' => 'Email o contraseña incorrectos']);
        }
    } catch(PDOException $e) {
        echo json_encode(['error' => 'Error en login: ' . $e->getMessage()]);
    }
}

function register($conn) {
    $data = json_decode(file_get_contents('php://input'), true);
    
    if (!$data) {
        echo json_encode(['error' => 'Datos no válidos']);
        return;
    }
    
    $required = ['nombre', 'apellido', 'email', 'password'];
    foreach ($required as $field) {
        if (empty($data[$field])) {
            echo json_encode(['error' => "El campo $field es requerido"]);
            return;
        }
    }
    
    try {
        // Verificar si email ya existe
        $stmt = $conn->prepare("SELECT id FROM usuarios WHERE email = ?");
        $stmt->execute([$data['email']]);
        if ($stmt->fetch()) {
            echo json_encode(['error' => 'El email ya está registrado']);
            return;
        }
        
        $sql = "INSERT INTO usuarios (idrol, nombre, apellido, email, password, telefono, status, created_at) 
                VALUES (?, ?, ?, ?, ?, ?, 1, NOW())";
        
        $stmt = $conn->prepare($sql);
        $stmt->execute([
            3, // Rol de cliente por defecto
            $data['nombre'],
            $data['apellido'],
            $data['email'],
            md5($data['password']),
            $data['telefono'] ?? ''
        ]);
        
        echo json_encode([
            'success' => true,
            'message' => 'Usuario registrado exitosamente',
            'id' => $conn->lastInsertId()
        ]);
    } catch(PDOException $e) {
        echo json_encode(['error' => 'Error al registrar usuario: ' . $e->getMessage()]);
    }
}

function logout() {
    echo json_encode([
        'success' => true,
        'message' => 'Logout exitoso'
    ]);
}
?>
