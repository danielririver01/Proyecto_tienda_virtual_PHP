<?php
// Vercel Serverless Function Entry Point
header('Content-Type: application/json');

// Simular el enrutamiento del proyecto original
$path = $_SERVER['REQUEST_URI'] ?? '/';
$path = parse_url($path, PHP_URL_PATH);

// Eliminar /api/ del inicio si existe
$path = str_replace('/api', '', $path);

// Cargar configuración básica
require_once __DIR__ . '/../Config/Config.php';

// Enrutamiento básico para API endpoints
switch ($path) {
    case '/':
        echo json_encode(['message' => 'Tienda Virtual API']);
        break;
    case '/productos':
        // Simular endpoint de productos
        echo json_encode(['productos' => []]);
        break;
    default:
        http_response_code(404);
        echo json_encode(['error' => 'Endpoint no encontrado']);
        break;
}
?>
