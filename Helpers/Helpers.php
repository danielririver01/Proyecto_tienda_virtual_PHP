<?php 
    use PHPMailer\PHPMailer\PHPMailer;
    use PHPMailer\PHPMailer\Exception;
    require 'Libraries/phpmailer/Exception.php';
    require 'Libraries/phpmailer/PHPMailer.php';
    require 'Libraries/phpmailer/SMTP.php';

	//Retorla la url del proyecto
	function base_url()
	{
		return BASE_URL;
	}
    //Retorla la url de Assets
    function media()
    {
        return BASE_URL."/Assets";
    }
    function headerAdmin($data="")
    {
        $view_header = "Views/Template/header_admin.php";
        require_once ($view_header);
    }
    function footerAdmin($data="")
    {
        $view_footer = "Views/Template/footer_admin.php";
        require_once ($view_footer);        
    }
    function headerTienda($data="")
    {
        $view_header = "Views/Template/header_tienda.php";
        require_once ($view_header);
    }
    function footerTienda($data="")
    {
        $view_footer = "Views/Template/footer_tienda.php";
        require_once ($view_footer);        
    }
	//Muestra información formateada
	function dep($data)
    {
        $format  = print_r('<pre>');
        $format .= print_r($data);
        $format .= print_r('</pre>');
        return $format;
    }
    function getModal(string $nameModal, $data)
    {
        $view_modal = "Views/Template/Modals/{$nameModal}.php";
        require_once $view_modal;        
    }
    function getFile(string $url, $data)
    {
        ob_start();
        require_once("Views/{$url}.php");
        $file = ob_get_clean();
        return $file;        
    }
    function sendEmail($data,$template)
    {
        ob_start();
        require_once("Views/Template/Email/".$template.".php");
        $mensaje = ob_get_clean();
        $driver = defined('MAIL_DRIVER') ? MAIL_DRIVER : (ENVIRONMENT == 1 ? 'mail' : 'smtp');
        if($driver === 'smtp' && defined('MAIL_HOST') && MAIL_HOST !== ''){
            $mail = new PHPMailer(true);
            try {
                $mail->SMTPDebug = defined('MAIL_DEBUG') ? MAIL_DEBUG : 0;
                $mail->isSMTP();
                $mail->Host = MAIL_HOST;
                $mail->SMTPAuth = defined('MAIL_AUTH') ? MAIL_AUTH : true;
                $mail->Username = defined('MAIL_USER') ? MAIL_USER : '';
                $mail->Password = defined('MAIL_PASSWORD') ? MAIL_PASSWORD : '';
                $secure = strtolower(defined('MAIL_SECURE') ? MAIL_SECURE : '');
                if($secure === 'ssl'){
                    $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
                    $mail->Port = (defined('MAIL_PORT') && MAIL_PORT > 0) ? MAIL_PORT : 465;
                }elseif($secure === 'tls'){
                    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
                    $mail->Port = (defined('MAIL_PORT') && MAIL_PORT > 0) ? MAIL_PORT : 587;
                }else{
                    $mail->Port = (defined('MAIL_PORT') && MAIL_PORT > 0) ? MAIL_PORT : 25;
                }
                $fromEmail = defined('MAIL_FROM') ? MAIL_FROM : EMAIL_REMITENTE;
                $fromName = defined('MAIL_FROM_NAME') ? MAIL_FROM_NAME : NOMBRE_REMITENTE;
                $replyTo = defined('MAIL_REPLY_TO') ? MAIL_REPLY_TO : '';
                $mail->setFrom($fromEmail, $fromName);
                if(!empty($replyTo)){
                    $mail->addReplyTo($replyTo);
                }
                $mail->addAddress($data['email']);
                if(!empty($data['emailCopia'])){
                    $mail->addBCC($data['emailCopia']);
                }
                if(!empty($data['adjuntos']) && is_array($data['adjuntos'])){
                    foreach($data['adjuntos'] as $a){
                        if(is_string($a) && is_file($a)){
                            $mail->addAttachment($a);
                        }
                    }
                }
                $mail->CharSet = 'UTF-8';
                $mail->isHTML(true);
                $mail->Subject = $data['asunto'];
                $mail->Body = $mensaje;
                $mail->send();
                if(function_exists('securityLog')){ securityLog('email_send',["to"=>$data['email'],"template"=>$template,"driver"=>'smtp']); }
                return true;
            } catch (Exception $e) {
                if(function_exists('securityLog')){ securityLog('email_error',["to"=>$data['email'],"template"=>$template,"driver"=>'smtp',"error"=>$mail->ErrorInfo]); }
                return false;
            }
        } else {
            $asunto = $data['asunto'];
            $emailDestino = $data['email'];
            $empresa = defined('MAIL_FROM_NAME') ? MAIL_FROM_NAME : NOMBRE_REMITENTE;
            $remitente = defined('MAIL_FROM') ? MAIL_FROM : EMAIL_REMITENTE;
            $emailCopia = !empty($data['emailCopia']) ? $data['emailCopia'] : "";
            $de = "MIME-Version: 1.0\r\n";
            $de .= "Content-type: text/html; charset=UTF-8\r\n";
            $de .= "From: {$empresa} <{$remitente}>\r\n";
            if(!empty($emailCopia)){$de .= "Bcc: $emailCopia\r\n";}
            $send = mail($emailDestino, $asunto, $mensaje, $de);
            if(function_exists('securityLog')){ securityLog($send ? 'email_send' : 'email_error',["to"=>$data['email'],"template"=>$template,"driver"=>'mail']); }
            return $send;
        }
    }

    function sendMailLocal($data,$template){
        //Create an instance; passing `true` enables exceptions
        $mail = new PHPMailer(true);
        ob_start();
        require_once("Views/Template/Email/".$template.".php");
        $mensaje = ob_get_clean();

        try {
            //Server settings
            $mail->SMTPDebug = 1;                      //Enable verbose debug output
            $mail->isSMTP();                                            //Send using SMTP
            $mail->Host       = 'smtp.gmail.com';                     //Set the SMTP server to send through
            $mail->SMTPAuth   = true;                                   //Enable SMTP authentication
            $mail->Username   = 'toolsfordeveloper@gmail.com';                     //SMTP username
            $mail->Password   = '';                               //SMTP password
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;            //Enable implicit TLS encryption
            $mail->Port       = 465;                                    //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`

            //Recipients
            $mail->setFrom('toolsfordeveloper@gmail.com', 'Servidor Local');
            $mail->addAddress($data['email']);     //Add a recipient
            if(!empty($data['emailCopia'])){
                $mail->addBCC($data['emailCopia']);
            }

            //Content
            $mail->isHTML(true);                                  //Set email format to HTML
            $mail->Subject = $data['asunto'];
            $mail->Body    = $mensaje;
            
            $mail->send();
            echo 'Mensaje enviado';
        } catch (Exception $e) {
            echo "Error en el envío del mensaje: {$mail->ErrorInfo}";
        }
    }

    function getPermisos(int $idmodulo){
        require_once ("Models/PermisosModel.php");
        $objPermisos = new PermisosModel();
        if(!empty($_SESSION['userData'])){
            $idrol = $_SESSION['userData']['idrol'];
            $arrPermisos = $objPermisos->permisosModulo($idrol);
            $permisos = '';
            $permisosMod = '';
            if(count($arrPermisos) > 0 ){
                $permisos = $arrPermisos;
                $permisosMod = isset($arrPermisos[$idmodulo]) ? $arrPermisos[$idmodulo] : "";
            }
            $_SESSION['permisos'] = $permisos;
            $_SESSION['permisosMod'] = $permisosMod;
        }
    }

    function sessionUser(int $idpersona){
        require_once ("Models/LoginModel.php");
        $objLogin = new LoginModel();
        $request = $objLogin->sessionLogin($idpersona);
        return $request;
    }

    function uploadImage(array $data, string $name){
        $url_temp = $data['tmp_name'];
        $destino    = 'Assets/images/uploads/'.$name;        
        $move = move_uploaded_file($url_temp, $destino);
        return $move;
    }

    function deleteFile(string $name){
        unlink('Assets/images/uploads/'.$name);
    }

    //Elimina exceso de espacios entre palabras
    function strClean($strCadena){
        $string = preg_replace(['/\s+/','/^\s|\s$/'],[' ',''], $strCadena);
        $string = trim($string); //Elimina espacios en blanco al inicio y al final
        $string = stripslashes($string); // Elimina las \ invertidas
        $string = str_ireplace("<script>","",$string);
        $string = str_ireplace("</script>","",$string);
        $string = str_ireplace("<script src>","",$string);
        $string = str_ireplace("<script type=>","",$string);
        $string = str_ireplace("SELECT * FROM","",$string);
        $string = str_ireplace("DELETE FROM","",$string);
        $string = str_ireplace("INSERT INTO","",$string);
        $string = str_ireplace("SELECT COUNT(*) FROM","",$string);
        $string = str_ireplace("DROP TABLE","",$string);
        $string = str_ireplace("OR '1'='1","",$string);
        $string = str_ireplace('OR "1"="1"',"",$string);
        $string = str_ireplace('OR ´1´=´1´',"",$string);
        $string = str_ireplace("is NULL; --","",$string);
        $string = str_ireplace("is NULL; --","",$string);
        $string = str_ireplace("LIKE '","",$string);
        $string = str_ireplace('LIKE "',"",$string);
        $string = str_ireplace("LIKE ´","",$string);
        $string = str_ireplace("OR 'a'='a","",$string);
        $string = str_ireplace('OR "a"="a',"",$string);
        $string = str_ireplace("OR ´a´=´a","",$string);
        $string = str_ireplace("OR ´a´=´a","",$string);
        $string = str_ireplace("--","",$string);
        $string = str_ireplace("^","",$string);
        $string = str_ireplace("[","",$string);
        $string = str_ireplace("]","",$string);
        $string = str_ireplace("==","",$string);
        return $string;
    }

    function clear_cadena(string $cadena){
        //Reemplazamos la A y a
        $cadena = str_replace(
        array('Á', 'À', 'Â', 'Ä', 'á', 'à', 'ä', 'â', 'ª'),
        array('A', 'A', 'A', 'A', 'a', 'a', 'a', 'a', 'a'),
        $cadena
        );
 
        //Reemplazamos la E y e
        $cadena = str_replace(
        array('É', 'È', 'Ê', 'Ë', 'é', 'è', 'ë', 'ê'),
        array('E', 'E', 'E', 'E', 'e', 'e', 'e', 'e'),
        $cadena );
 
        //Reemplazamos la I y i
        $cadena = str_replace(
        array('Í', 'Ì', 'Ï', 'Î', 'í', 'ì', 'ï', 'î'),
        array('I', 'I', 'I', 'I', 'i', 'i', 'i', 'i'),
        $cadena );
 
        //Reemplazamos la O y o
        $cadena = str_replace(
        array('Ó', 'Ò', 'Ö', 'Ô', 'ó', 'ò', 'ö', 'ô'),
        array('O', 'O', 'O', 'O', 'o', 'o', 'o', 'o'),
        $cadena );
 
        //Reemplazamos la U y u
        $cadena = str_replace(
        array('Ú', 'Ù', 'Û', 'Ü', 'ú', 'ù', 'ü', 'û'),
        array('U', 'U', 'U', 'U', 'u', 'u', 'u', 'u'),
        $cadena );
 
        //Reemplazamos la N, n, C y c
        $cadena = str_replace(
        array('Ñ', 'ñ', 'Ç', 'ç',',','.',';',':'),
        array('N', 'n', 'C', 'c','','','',''),
        $cadena
        );
        return $cadena;
    }
    //Genera una contraseña de 10 caracteres
	function passGenerator($length = 10)
    {
        $pass = "";
        $longitudPass=$length;
        $cadena = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
        $longitudCadena=strlen($cadena);

        for($i=1; $i<=$longitudPass; $i++)
        {
            $pos = rand(0,$longitudCadena-1);
            $pass .= substr($cadena,$pos,1);
        }
        return $pass;
    }
    //Genera un token
    function token()
    {
        $r1 = bin2hex(random_bytes(10));
        $r2 = bin2hex(random_bytes(10));
        $r3 = bin2hex(random_bytes(10));
        $r4 = bin2hex(random_bytes(10));
        $token = $r1.'-'.$r2.'-'.$r3.'-'.$r4;
        return $token;
    }
    //Formato para valores monetarios
    function formatMoney($cantidad){
        $cantidad = number_format($cantidad,2,SPD,SPM);
        return $cantidad;
    }

    function getAppEnv(){
        $v = getenv('APP_ENV');
        return $v ? $v : 'development';
    }

    function passwordAlgo(){
        $env = getAppEnv();
        if(defined('PASSWORD_ARGON2ID')){
            if($env === 'production'){
                return [PASSWORD_ARGON2ID,["memory_cost"=>131072,"time_cost"=>5,"threads"=>2]];
            }
            return [PASSWORD_ARGON2ID,["memory_cost"=>65536,"time_cost"=>3,"threads"=>2]];
        }
        if($env === 'production'){ return [PASSWORD_BCRYPT,["cost"=>15]]; }
        return [PASSWORD_BCRYPT,["cost"=>12]];
    }

    function hashPassword($pwd){
        [$algo,$opt] = passwordAlgo();
        return password_hash($pwd,$algo,$opt);
    }

    function isCommonPassword($p){
        $list = ['123456','password','qwerty','123456789','111111','abc123','123123','iloveyou','admin'];
        return in_array(strtolower($p),$list,true);
    }

    function validarPasswordFuerte($p){
        $ok = true; $msgs = [];
        if(strlen($p) < 10){ $ok = false; $msgs[] = 'La contraseña debe tener al menos 10 caracteres.'; }
        if(!preg_match('/[A-Z]/',$p)){ $ok = false; $msgs[] = 'Debe incluir al menos una letra mayúscula.'; }
        if(!preg_match('/\d/',$p)){ $ok = false; $msgs[] = 'Debe incluir al menos un número.'; }
        if(isCommonPassword($p)){ $ok = false; $msgs[] = 'Contraseña demasiado común.'; }
        return ['ok'=>$ok,'mensajes'=>$msgs];
    }

    function securityLog($event,$meta=[]){
        $dir = __DIR__.'/../../storage/logs';
        if(!is_dir($dir)){ @mkdir($dir,0777,true); }
        $line = date('c')."|".$event."|".json_encode($meta)."\n";
        @file_put_contents($dir.'/security.log',$line,FILE_APPEND);
    }
    
    function getTokenPaypal(){
        $payLogin = curl_init(URLPAYPAL."/v1/oauth2/token");
        curl_setopt($payLogin, CURLOPT_SSL_VERIFYPEER, TRUE);
        curl_setopt($payLogin, CURLOPT_SSL_VERIFYHOST, 2);
        curl_setopt($payLogin, CURLOPT_RETURNTRANSFER,TRUE);
        curl_setopt($payLogin, CURLOPT_USERPWD, IDCLIENTE.":".SECRET);
        curl_setopt($payLogin, CURLOPT_POSTFIELDS, "grant_type=client_credentials");
        $result = curl_exec($payLogin);
        $err = curl_error($payLogin);
        curl_close($payLogin);
        if($err){
            $request = "CURL Error #:" . $err;
        }else{
            $objData = json_decode($result);
             $request =  $objData->access_token;
        }
        return $request;
    }

    function CurlConnectionGet(string $ruta, string $contentType = null, string $token){
        $content_type = $contentType != null ? $contentType : "application/x-www-form-urlencoded";
        if($token != null){
            $arrHeader = array('Content-Type:'.$content_type,
                            'Authorization: Bearer '.$token);
        }else{
            $arrHeader = array('Content-Type:'.$content_type);
        }
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $ruta);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, TRUE);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $arrHeader);
        $result = curl_exec($ch);
        $err = curl_error($ch);
        curl_close($ch);
        if($err){
            $request = "CURL Error #:" . $err;
        }else{
            $request = json_decode($result);
        }
        return $request;
    }

    function CurlConnectionPost(string $ruta, string $contentType = null, string $token){
        $content_type = $contentType != null ? $contentType : "application/x-www-form-urlencoded";
        if($token != null){
            $arrHeader = array('Content-Type:'.$content_type,
                            'Authorization: Bearer '.$token);
        }else{
            $arrHeader = array('Content-Type:'.$content_type);
        }
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $ruta);
        curl_setopt($ch, CURLOPT_POST, TRUE);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, TRUE);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $arrHeader);
        $result = curl_exec($ch);
        $err = curl_error($ch);
        curl_close($ch);
        if($err){
            $request = "CURL Error #:" . $err;
        }else{
            $request = json_decode($result);
        }
        return $request;
    }

    function Meses(){
        $meses = array("Enero", 
                      "Febrero", 
                      "Marzo", 
                      "Abril", 
                      "Mayo", 
                      "Junio", 
                      "Julio", 
                      "Agosto", 
                      "Septiembre", 
                      "Octubre", 
                      "Noviembre", 
                      "Diciembre");
        return $meses;
    }

    function getCatFooter(){
        require_once ("Models/CategoriasModel.php");
        $objCategoria = new CategoriasModel();
        $request = $objCategoria->getCategoriasFooter();
        return $request;
    }

    function getInfoPage(int $idpagina){
        require_once("Libraries/Core/Mysql.php");
        $con = new Mysql();
        $sql = "SELECT * FROM post WHERE idpost = $idpagina";
        $request = $con->select($sql);
        return $request;
    }

    function getPageRout(string $ruta){
        require_once("Libraries/Core/Mysql.php");
        $con = new Mysql();
        $sql = "SELECT * FROM post WHERE ruta = '$ruta' AND status != 0 ";
        $request = $con->select($sql);
        if(!empty($request)){
            $request['portada'] = $request['portada'] != "" ? media()."/images/uploads/".$request['portada'] : "";
        }
        return $request;
    }

    function viewPage(int $idpagina){
        require_once("Libraries/Core/Mysql.php");
        $con = new Mysql();
        $sql = "SELECT * FROM post WHERE idpost = $idpagina ";
        $request = $con->select($sql);
        if( ($request['status'] == 2 AND isset($_SESSION['permisosMod']) AND $_SESSION['permisosMod']['u'] == true) OR $request['status'] == 1){
            return true;        
        }else{
            return false;
        }
    }

 ?>
