<?php
    require_once("db.php");

    class category extends db{

        public function checkcategory($categoryid,$categoryname){
            $sql="CALL `sp_checkcategory`({$categoryid},'{$categoryname}')";
            return $this->getdata($sql)->rowCount();
        }

        public function savecategory($categoryid,$categoryname){
            if($this->checkcategory($categoryid,$categoryname)){
                return "exists";
            }else{
                $sql="CALL `sp_savecategory`({$categoryid},'{$categoryname}', {$this->userid})";
                $this->getdata($sql);
                return "success";
            }
           
        }

        public function getcategories(){
            $sql="CALL `sp_getcategories`()";
            return $this->getjson();
        }

    }

?>