<?php 

	class LoginModel extends Mysql
	{
		private $intIdUsuario;
		private $strUsuario;
		private $strPassword;
		private $strToken;

		public function __construct()
		{
			parent::__construct();
		}	

        public function loginUser(string $usuario, string $password)
        {
            $this->strUsuario = $usuario;
            $this->strPassword = $password;
            $sql = "SELECT idpersona,status,password FROM persona WHERE email_user = '$this->strUsuario' and status != 0 LIMIT 1";
            $request = $this->select($sql);
            if(empty($request)) return $request;
            $stored = $request['password'];
            $ok = false; $needRehash = false; $newHash = '';
            if(is_string($stored) && strlen($stored) >= 60 && (strpos($stored,'$2y$') === 0 || strpos($stored,'$argon2id$') === 0)){
                $ok = password_verify($this->strPassword,$stored);
                if($ok && password_needs_rehash($stored, passwordAlgo()[0], passwordAlgo()[1])){ $needRehash = true; $newHash = hashPassword($this->strPassword); }
            }elseif(is_string($stored) && strlen($stored) === 64 && ctype_xdigit($stored)){
                $ok = (hash('sha256',$this->strPassword) === $stored);
                if($ok){ $needRehash = true; $newHash = hashPassword($this->strPassword); }
            }else{
                $ok = ($this->strPassword === $stored);
                if($ok){ $needRehash = true; $newHash = hashPassword($this->strPassword); }
            }
            if($ok){
                if($needRehash){
                    $id = intval($request['idpersona']);
                    $sqlU = "UPDATE persona SET password = ? WHERE idpersona = $id";
                    $this->update($sqlU, [$newHash]);
                    securityLog('password_migrated',["idpersona"=>$id]);
                }
                unset($request['password']);
                return $request;
            }
            return [];
        }

		public function sessionLogin(int $iduser){
			$this->intIdUsuario = $iduser;
			//BUSCAR ROLE 
			$sql = "SELECT p.idpersona,
							p.identificacion,
							p.nombres,
							p.apellidos,
							p.telefono,
							p.email_user,
							p.nit,
							p.nombrefiscal,
							p.direccionfiscal,
							r.idrol,r.nombrerol,
							p.status 
					FROM persona p
					INNER JOIN rol r
					ON p.rolid = r.idrol
					WHERE p.idpersona = $this->intIdUsuario";
			$request = $this->select($sql);
			$_SESSION['userData'] = $request;
			return $request;
		}

		public function getUserEmail(string $strEmail){
			$this->strUsuario = $strEmail;
			$sql = "SELECT idpersona,nombres,apellidos,status FROM persona WHERE 
					email_user = '$this->strUsuario' and  
					status = 1 ";
			$request = $this->select($sql);
			return $request;
		}

		public function setTokenUser(int $idpersona, string $token){
			$this->intIdUsuario = $idpersona;
			$this->strToken = $token;
			$sql = "UPDATE persona SET token = ? WHERE idpersona = $this->intIdUsuario ";
			$arrData = array($this->strToken);
			$request = $this->update($sql,$arrData);
			return $request;
		}

		public function getUsuario(string $email, string $token){
			$this->strUsuario = $email;
			$this->strToken = $token;
			$sql = "SELECT idpersona FROM persona WHERE 
					email_user = '$this->strUsuario' and 
					token = '$this->strToken' and 					
					status = 1 ";
			$request = $this->select($sql);
			return $request;
		}

		public function insertPassword(int $idPersona, string $password){
			$this->intIdUsuario = $idPersona;
			$this->strPassword = $password;
			$sql = "UPDATE persona SET password = ?, token = ? WHERE idpersona = $this->intIdUsuario ";
			$arrData = array($this->strPassword,"");
			$request = $this->update($sql,$arrData);
			return $request;
		}
	}
 ?>
