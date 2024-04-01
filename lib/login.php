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

// Query database untuk mendapatkan hash password dan username berdasarkan email
$query = "SELECT *
          FROM `user`
          WHERE `email` = '$email'";
$result = mysqli_query($db, $query);

if ($result && mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_assoc($result);
    $hashed_password_from_db = $row['password'];
    $username = $row['username'];
    $name = $row['name'];
    $email = $row['email'];
    $alamat = $row['alamat'];
    $agama = $row['agama'];
    $tanggal_lahir = $row['tanggal_lahir'];

    // Verifikasi password
    if (password_verify($password, $hashed_password_from_db)) {
        // Password cocok, kirim respons JSON dengan status sukses dan informasi username
        echo json_encode(array(
            'status' => 'success', 
            'username' => $username, 
            'name' => $name, 
            'email' => $email, 
            'alamat' => $alamat,
            'agama' => $agama, 
            'tanggal_lahir' => $tanggal_lahir, 
            'message' => 'Login berhasil'));
    } else {
        // Password tidak cocok
        echo json_encode(array('status' => 'error', 'message' => 'Password salah'));
    }
} else {
    // Email tidak ditemukan di database
    echo json_encode(array('status' => 'error', 'message' => 'Email tidak ditemukan'));
}

// Tutup koneksi database
mysqli_close($db);
?>
