<?php
$conn = oci_connect("db2021863026","db98716545", "localhost/lecture");
if(!$conn) exit("DB 연결 실패");

$title = $_GET["title"];
$year  = $_GET["year"];

$sql = "
    select length
    from movie
    where upper(title) = upper('$title')
      and year = $year
";

$stmt = oci_parse($conn, $sql);
oci_execute($stmt);

$row = oci_fetch_array($stmt, OCI_ASSOC);

if($row){
    echo "length = ".$row["LENGTH"];
}else{
    echo "영화 없음";
}
?>
