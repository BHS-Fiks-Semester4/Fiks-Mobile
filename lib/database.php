<?php
$db = mysqli_connect("localhost", "root", "", "akhwat-computer");

if (mysqli_connect_errno()) {
    echo "Koneksi gagal : ".mysqli_connect_error();
}
?>