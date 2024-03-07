<?php
// Izinkan akses dari semua sumber
header("Access-Control-Allow-Origin: *");
// Izinkan metode permintaan yang diizinkan
header("Access-Control-Allow-Methods: POST, OPTIONS");
// Izinkan header tambahan yang diizinkan
header("Access-Control-Allow-Headers: Content-Type");

// Pastikan hanya respons yang valid yang akan dikirimkan
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}
require_once('database.php');

$email = mysqli_real_escape_string($db, $_POST["email"]);
$password = $_POST["password"];

// Query database untuk mendapatkan hash password berdasarkan email
$query = "SELECT `password`
          FROM `user`
          WHERE `email` = '$email'";
$result = mysqli_query($db, $query);

if ($result && mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_assoc($result);
    $hashed_password_from_db = $row['password'];

    // Verifikasi password
    if (password_verify($password, $hashed_password_from_db)) {
        // Password cocok, lakukan tindakan setelah login sukses
        echo json_encode(array('status' => 'success', 'message' => 'Login berhasil'));
    } else {
        // Password tidak cocok
        echo json_encode(array('status' => 'error', 'message' => 'Email atau password salah'));
    }
} else {
    // Email tidak ditemukan di database
    echo json_encode(array('status' => 'error', 'message' => 'Email tidak ditemukan'));
}

// Tutup koneksi database
mysqli_close($db);
?>
