<?php


namespace myapp\api;


use Handlers\components\APIHandler;

class simpleAPIHandler extends APIHandler
{
    function indexAction(){
        self::setVar("msg","ok");
        $this->toJSON();
    }
}