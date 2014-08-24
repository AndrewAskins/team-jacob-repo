<?php

require_once("Toro.php");

require_once("handlers/NullHandler.php");
require_once("handlers/SearchHandler.php");
require_once("handlers/ReviewHandler.php");
require_once("handlers/DetailHandler.php");
require_once("handlers/SimilarHandler.php");

require_once("lib/config.dev.php");
require_once("lib/utils.php");

require_once(__DIR__ . '/vendor/Httpful/Bootstrap.php');

// Initialize Httpful
\Httpful\Bootstrap::init();

// Initialize Toro routing
ToroHook::add("404", function() {
    http_response_code(400);
    echo json_encode(array('error' => 'Does not exist. Deal with it.'));
});

Toro::serve(array(
    "/" => "NullHandler",
    "/search" => "SearchHandler",
    "/reviews" => "ReviewHandler",
    "/details" => "DetailHandler",
    "/similar" => "SimilarHandler"
));
