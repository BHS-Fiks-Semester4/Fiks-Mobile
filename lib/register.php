<?php
// Izinkan akses dari semua sumber
header("Access-Control-Allow-Origin: *");
// Izinkan metode permintaan yang diizinkan
header("Access-Control-Allow-Methods: POST, OPTIONS");
// Izinkan header tambahan yang diizinkan
header("Access-Control-Allow-Headers: Content-Type");
// Set tipe konten menjadi JSON
header('Content-Type: application/json');

// Pastikan hanya respons yang valid yang akan dikirimkan
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

require_once('database.php');

$response = array();

if (isset($_POST['namaLengkap'], $_POST['username'], $_POST['tanggalLahir'], $_POST['selectedRegion'], $_POST['alamat'], $_POST['noHP'], $_POST['email'], $_POST['password'], $_POST['confirmPassword'])) {
    $nama               = $_POST['namaLengkap'];
    $username           = $_POST['username'];
    $tanggalLahir       = $_POST['tanggalLahir'];
    $agama              = $_POST['selectedRegion'];
    $alamat             = $_POST['alamat'];
    $noHp               = $_POST['noHP'];
    $email              = $_POST['email'];
    $password           = $_POST['password'];
    $confirmPassword    = $_POST['confirmPassword'];

    if ($password !== $confirmPassword) {
        $response['success'] = false;
        $response['message'] = "Password dan konfirmasi password tidak cocok";
    } else {
        // Hash password menggunakan bcrypt
        $hashedPassword = password_hash($password, PASSWORD_BCRYPT);

        $query = "INSERT INTO user (
                    name, 
                    username, 
                    tanggal_lahir, 
                    agama, 
                    alamat, 
                    no_hp, 
                    email, 
                    password
                ) VALUES (
                    ?, ?, ?, ?, ?, ?, ?, ?
                )";

        $statement = $db->prepare($query);
        $statement->bind_param('ssssssss', $nama, $username, $tanggalLahir, $agama, $alamat, $noHp, $email, $hashedPassword);

        if ($statement->execute()) {
            $response['success'] = true;
            $response['message'] = "Data berhasil dimasukkan";
        } else {
            $response['success'] = false;
            $response['message'] = "Data gagal dimasukkan";
        }
    }
} else {
    $response['success'] = false;
    $response['message'] = 'Data yang diperlukan tidak diterima.';
}

echo json_encode($response);
?>
