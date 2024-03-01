<?php
require_once('database.php');

$username = $_POST["username"];
$password = $_POST["password"];

// Cek apakah sesuai dengan database
$query = "SELECT `username-user`, `password-user`
          FROM `user`
          WHERE `username-user` = '$username' AND `password-user` = '$password'";

$obj_query = mysqli_query($db, $query);

if ($obj_query && mysqli_num_rows($obj_query) > 0) {
    $data = mysqli_fetch_assoc($obj_query);
    echo json_encode(
        array(
            'response' => true,
            'payload' => array(
                "username" => $data["username-user"],
                "password" => $data["password-user"]
            )
        )
    );
} else {
    echo json_encode(
        array(
            'response' => false,
            'payload' => null
        )
    );
}

header('Content-Type:application/json');
?>
