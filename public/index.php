<?php

require_once '../vendor/autoload.php';



use Handlers\components\ConfigParams;


ConfigParams::$APP_LANG = "es";
ConfigParams::$APP_DEFAULT_HANDLER = "test";

\Handlers\data_access\SimpleDAO::connect("localhost","sys_warzone","root","");

if(!\Handlers\components\XHandler::exec("myapp")){
    header("location:" . ConfigParams::$APP_DEFAULT_HANDLER);

}