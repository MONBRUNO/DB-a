<?php
function p_error($id=null){
    if($id==null)$e=oci_error();
    else $e = oci_error($id);
    print htmlentities($e['message']);
    exit();
}

$conn = oci_connect("db2021863026","db98716545", "localhost/lecture");
if(!$conn) p_error();

$stmt = oci_parse($conn,
    "select s.name, count(*) cnt
     from studio s, movie m
     where m.studioname = s.name
     group by s.name
     order by s.name"
);
if(!$stmt) p_error($conn);

$r = oci_execute($stmt);
if(!$r) p_error($stmt);

print "<TABLE bgcolor=#f0f0ff border=1 cellspacing=2>\n";
print "<TR bgcolor=#ccccff align=center><TH> 영화사 <TH> 제작한 영화수</TR>\n";

while($row = oci_fetch_array($stmt)){
    print "<TR> <TD><a href='studio_info.php?name={$row[0]}'>{$row[0]}</a> <TD><a href='studio_movies.php?name={$row[0]}'>{$row['CNT']}</a> </TR>\n";
}

print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>