<?php
$conn = oci_connect("db아이디","db비밀번호","localhost/lecture");
if(!$conn) exit("DB 연결 실패");

$name = $_GET["name"];

$sql = "
    update studio
    set address = 'Seoul'
    where upper(name) = upper('$name')
";

$stmt = oci_parse($conn, $sql);
oci_execute($stmt);

echo "updated rows = ".oci_num_rows($stmt);
?>
<?php

/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Scripting/EmptyPHP.php to edit this template
 */

