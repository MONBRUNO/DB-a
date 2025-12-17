<?php
function p_error($id=null){
    if($id==null)$e=oci_error();
    else $e = oci_error($id);
    print htmlentities($e['message']);
    exit();
}

$conn = oci_connect("db2021863026","db98716545","localhost/lecture");
if(!$conn) p_error();

$name = $_GET["name"];

$stmt = oci_parse($conn,
    "select m.title, m.year, m.length, e.name producer
     from movie m, movieexec e
     where m.producerno = e.certno and m.studioname = :n
     order by m.year, m.title"
);
if(!$stmt) p_error($conn);

oci_bind_by_name($stmt, ":n", $name);

$r = oci_execute($stmt);
if(!$r) p_error($stmt);

print "<h3>{$name} 제작 영화 목록</h3>";
print "<TABLE bgcolor=#e0f7ff border=1 cellspacing=2>\n";
print "<TR bgcolor=#99ddff align=center><TH> 제목 <TH> 개봉년도 <TH> 상영시간 <TH> 제작자</TR>\n";

while($row = oci_fetch_array($stmt)){
    print "<TR> <TD> {$row[0]} <TD> {$row[1]}년 <TD> {$row[2]}분 <TD> {$row['PRODUCER']} </TR>\n";
}

print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>
