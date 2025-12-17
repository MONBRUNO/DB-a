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
    "select s.name sname, s.address saddr, e.name boss, e.address baddr, e.networth net
     from studio s, movieexec e
     where s.presno = e.certno and s.name = :n"
);
if(!$stmt) p_error($conn);

oci_bind_by_name($stmt, ":n", $name);

$r = oci_execute($stmt);
if(!$r) p_error($stmt);

print "<h3>{$name} 영화사 정보</h3>";
print "<TABLE bgcolor=#ffeecc border=1 cellspacing=2>\n";
print "<TR bgcolor=#ffcc99 align=center><TH> 이름 <TH> 주소 <TH> 사장 <TH> 사장주소 <TH> 사장재산</TR>\n";

while($row = oci_fetch_array($stmt)){
    print "<TR> <TD> {$row['SNAME']} <TD> {$row['SADDR']} <TD> {$row['BOSS']} <TD> {$row['BADDR']} <TD> {$row['NET']} </TR>\n";
}

print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>
