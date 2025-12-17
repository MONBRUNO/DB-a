<?php
$conn = oci_connect("db아이디","db비밀번호","localhost/lecture");
if(!$conn) exit("DB 연결 실패");

$key = $_GET["key"];

$sql = "
    select title, year
    from movie
    where upper(title) like '%' || upper('$key') || '%'
    order by year, title
";

$stmt = oci_parse($conn, $sql);
oci_execute($stmt);

$cnt = 0;
while($row = oci_fetch_array($stmt, OCI_ASSOC)){
    $cnt++;
    echo $row["TITLE"]." (".$row["YEAR"].")<br>";
}

if($cnt == 0){
    echo "검색 결과 없음";
}
?>
