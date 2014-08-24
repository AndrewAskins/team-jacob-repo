<?php

class NullHandler {

    function get() {
        http_response_code(501);
        echo json_encode(array('error' => 'Not implemented yet.'));
    }

    function post() {
        http_response_code(501);
        echo json_encode(array('error' => 'Not implemented yet.'));
    }

}