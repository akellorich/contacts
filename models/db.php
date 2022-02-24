<?php
    session_start();
    $sql="";
   

    class db {
        private $servername;
        private $username;
        private $password;
        private $dbname;
        private $charset; 
        public $userid;
        // Remove this after implementing login 
        public function __construct(){
           $this->userid=isset($_SESSION['userid'])?$_SESSION['userid']:1;
        }

        public function connectdb(){
            $this->servername='localhost';
            $this->username='root';
            $this->password='';
            $this->charset='utf8mb4';
            $this->dbname='contacts';
            try{
                $dsn="mysql:host=".$this->servername.";dbname=".$this->dbname.";charset=".$this->charset;
                $pdo=new PDO($dsn,$this->username,$this->password);
                $pdo->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
                return $pdo;
            }catch(PDOException $e){
                echo "Connection failed: ".$e->getMessage();
            }
        }

        public function getdata($sql){
            return $this->connectdb()->query($sql);
        }

        public function getjson($sql){
            $rst=$this->getdata($sql);
            return json_encode($rst->fetchAll(PDO::FETCH_ASSOC));
        }

        public function mysqldate(){
            $date=DateTime::createFromFormat('d-M-Y',$date);
            return $date->format('Y-m-d');
        }
    }


?>