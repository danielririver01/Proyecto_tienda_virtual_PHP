<?php 
 $envPath = __DIR__ . '/../.env';
 $envVars = [];
 if (is_readable($envPath)) {
     $envVars = parse_ini_file($envPath, false, INI_SCANNER_TYPED) ?: [];
     foreach ($envVars as $k => $v) { if (!is_array($v)) { putenv($k.'='.$v); } }
 }
	//const BASE_URL = "http://localhost/tienda_virtual"; # solo para desarollo pero no debe ser usado para produccion
	const BASE_URL = getenv('BASE_URL') ?: "https://tu-app.onrender.com"; # para producción en Render

	//Zona horaria
	date_default_timezone_set('America/Bogota');

    $appEnv = getenv('APP_ENV') ?: 'development';
    $secureSecrets = getenv('APP_SECURE_SECRETS') === '1';
    $dbHost = getenv('DB_HOST') ?: ($appEnv === 'development' ? 'localhost' : '');
    $dbName = getenv('DB_NAME') ?: ($appEnv === 'development' ? 'db_tiendavirtual' : '');
    $dbUser = getenv('DB_USER') ?: ($appEnv === 'development' ? 'root' : '');
    $dbCharset = getenv('DB_CHARSET') ?: 'utf8mb4';
    $dbPassword = getenv('DB_PASSWORD') ?: '';
    if ($secureSecrets) {
        $k = getenv('APP_SECRET_KEY') ?: '';
        $iv = getenv('APP_SECRET_IV') ?: '';
        $enc = getenv('DB_PASSWORD_ENC') ?: '';
        if ($k !== '' && $iv !== '' && $enc !== '') {
            $dbPassword = openssl_decrypt(base64_decode($enc), 'AES-256-CBC', $k, 0, $iv) ?: '';
        }
    }
    if ($dbHost === '' || $dbName === '' || $dbUser === '') { die('Configuración de base de datos incompleta'); }
    define('DB_HOST', $dbHost);
    define('DB_NAME', $dbName);
    define('DB_USER', $dbUser);
    define('DB_PASSWORD', $dbPassword);
    define('DB_CHARSET', $dbCharset);

	//Para envío de correo
	const ENVIRONMENT = 1; // Local: 0, Produccón: 1;
	if (ENVIRONMENT === 1) { ini_set('display_errors','0'); } else { ini_set('display_errors','1'); }

	//Deliminadores decimal y millar Ej. 24,1989.00
	const SPD = ".";
	const SPM = ",";

	//Simbolo de moneda
	const SMONEY = "$";
	const CURRENCY = "USD";

	$paypalUrl = getenv('PAYPAL_URL') ?: 'https://api-m.sandbox.paypal.com';
	if (stripos($paypalUrl, 'https://') !== 0) { $paypalUrl = 'https://api-m.paypal.com'; }
	define('URLPAYPAL', $paypalUrl);
	$keyActive = getenv('PAYPAL_KEY_ACTIVE') ?: 'primary';
	$clientId = getenv('PAYPAL_CLIENT_ID_'.$keyActive) ?: '';
	$secretId = getenv('PAYPAL_SECRET_'.$keyActive) ?: '';
	define('IDCLIENTE', $clientId);
	define('SECRET', $secretId);
 


	//Datos envio de correo
	const NOMBRE_REMITENTE = "Tienda Virtual";
	const EMAIL_REMITENTE = "no-reply@abelosh.com";
	const NOMBRE_EMPESA = "Tienda Virtual";
	const WEB_EMPRESA = "www.abelosh.com";

	const DESCRIPCION = "La mejor tienda en línea con artículos de moda.";
	const SHAREDHASH = "TiendaVirtual";

	//Datos Empresa
	const DIRECCION = "Avenida las Américas Zona 13, Guatemala";
	const TELEMPRESA = "+(502)78787845";
	const WHATSAPP = "+50278787845";
	const EMAIL_EMPRESA = "info@abelosh.com";
	const EMAIL_PEDIDOS = "info@abelosh.com"; 
	const EMAIL_SUSCRIPCION = "info@abelosh.com";
	const EMAIL_CONTACTO = "info@abelosh.com";

	$mailDriver = getenv('MAIL_DRIVER') ?: 'smtp';
	$mailHost = getenv('MAIL_HOST') ?: '';
	$mailPort = intval(getenv('MAIL_PORT') ?: '0');
	$mailSecure = getenv('MAIL_SECURE') ?: '';
	$mailUser = getenv('MAIL_USER') ?: '';
	$mailPass = getenv('MAIL_PASSWORD') ?: '';
	if ($secureSecrets) {
		$encMail = getenv('MAIL_PASSWORD_ENC') ?: '';
		if ($k !== '' && $iv !== '' && $encMail !== '') {
			$mailPass = openssl_decrypt(base64_decode($encMail), 'AES-256-CBC', $k, 0, $iv) ?: $mailPass;
		}
	}
	$mailFrom = getenv('MAIL_FROM') ?: EMAIL_REMITENTE;
	$mailFromName = getenv('MAIL_FROM_NAME') ?: NOMBRE_REMITENTE;
	$mailReplyTo = getenv('MAIL_REPLY_TO') ?: EMAIL_EMPRESA;
	$mailDebug = intval(getenv('MAIL_DEBUG') ?: '0');
	$mailAuth = getenv('MAIL_AUTH') === '0' ? false : true;
	define('MAIL_DRIVER', $mailDriver);
	define('MAIL_HOST', $mailHost);
	define('MAIL_PORT', $mailPort);
	define('MAIL_SECURE', $mailSecure);
	define('MAIL_USER', $mailUser);
	define('MAIL_PASSWORD', $mailPass);
	define('MAIL_FROM', $mailFrom);
	define('MAIL_FROM_NAME', $mailFromName);
	define('MAIL_REPLY_TO', $mailReplyTo);
	define('MAIL_DEBUG', $mailDebug);
	define('MAIL_AUTH', $mailAuth);

	const CAT_SLIDER = "1,2,3";
	const CAT_BANNER = "4,5,6";
	const CAT_FOOTER = "1,2,3,4,5";

	//Datos para Encriptar / Desencriptar
	const KEY = 'abelosh';
	const METHODENCRIPT = "AES-128-ECB";

	//Envío
	const COSTOENVIO = 5;

	//Módulos
	const MDASHBOARD = 1;
	const MUSUARIOS = 2;
	const MCLIENTES = 3;
	const MPRODUCTOS = 4;
	const MPEDIDOS = 5;
	const MCATEGORIAS = 6;
	const MSUSCRIPTORES = 7;
	const MDCONTACTOS = 8;
	const MDPAGINAS = 9;

	//Páginas
	const PINICIO = 1;
	const PTIENDA = 2;
	const PCARRITO = 3;
	const PNOSOTROS = 4;
	const PCONTACTO = 5;
	const PPREGUNTAS = 6;
	const PTERMINOS = 7;
	const PSUCURSALES = 8;
	const PERROR = 9;

	//Roles
	const RADMINISTRADOR = 1;
	const RSUPERVISOR = 2;
	const RCLIENTES = 3;

	const STATUS = array('Completo','Aprobado','Cancelado','Reembolsado','Pendiente','Entregado');

	//Productos por página
	const CANTPORDHOME = 8;
	const PROPORPAGINA = 4;
	const PROCATEGORIA = 4;
	const PROBUSCAR = 4;

	//REDES SOCIALES
	const FACEBOOK = "#";
	const INSTAGRAM = "#";
	

 ?>
