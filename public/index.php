<?php

require_once '../vendor/autoload.php';


use Handlers\components\ConfigParams;


ConfigParams::loadConfigJson("../private/config.json");


if(!\Handlers\components\XHandler::exec("myapp")){

    header("location:" . ConfigParams::$PATH_ROOT . ConfigParams::$APP_DEFAULT_HANDLER);

}