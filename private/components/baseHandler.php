<?php
namespace myapp;

class baseHandler extends \Handlers\components\WebHandler
{
    function indexAction(){

        $this->display("../private/views/testView.php", array(
            "msg"=>"Hola Mundo"
        ));
    }
}