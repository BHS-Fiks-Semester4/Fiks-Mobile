<?php
require_once('database.php');

$email = $_POST["email"];
$password = $_POST["password"];

// Cek apakah sesuai dengan database
$query = "SELECT `email`, `password`
          FROM `user`
          WHERE `email` = '$email' AND `password` = '$password'";

$obj_query = mysqli_query($db, $query);

if ($obj_query && mysqli_num_rows($obj_query) > 0) {
    $data = mysqli_fetch_assoc($obj_query);
    echo json_encode(
        array(
            'response' => true,
            'payload' => array(
                "email" => $data["email"],
                "password" => $data["password"]
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
