<?php

    require_once("../models/categories.php");
    $category= new category();

    if(isset($_POST['savecategory'])){
        $categoryid=$_POST['categoryid'];
        $categoryname=$_POST['categoryname'];
        echo $category->savecategory($categoryid,$categoryname);
    }

    if(isset($_GET['getcategories'])){
        echo $category->getcategories();
    }
?>