<?php
$db = mysqli_connect("localhost", "root", "", "akhwat_computer2");

if (mysqli_connect_errno()) {
    echo "Koneksi gagal : ".mysqli_connect_error();
}
?>