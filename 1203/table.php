<?php

function p_error($id=null){
    if($id==null)$e=oci_error();
    else $e = oci_error($id);
    print htmlentities($e['message']);
    exit();
}

$conn = oci_connect("db2021863026","db98716545", "localhost/lecture");
if(!$conn) p_error();

$title = str_replace("","", $_GET["title"]);
$year = $_GET["year"];

$table = $_GET["table"];
if(!empty($table)) $table = "movie";

if(!empty($title)&&!empty($year))
    $cond="title='$title'and year=$year and";
else
    $cond = "";

$stmt=oci_parse($conn, "select * from ".$table);
if(!$stmt) p_error($conn);

$r = oci_execute($stmt);
if (!$r) p_error ($stmt);

print "<TABLE bgcolor=#abbcbabc border=1 cellspacing=2\n";

$nrows= oci_fetch_all($stmt, $r);
//$nrows= oci_fetch_all($stmt, $r, null, null, OCI_FETCHSTATEMENT_BY_ROW);
print"<TR bgcolor=#1ebcbabf align=center>";

foreach ($r as $k => $v){
    print"<th> $k";
}
print"</tr>\n";

for($i=0;$i<$nrows;$i++){
    print"<TR>";
    foreach($r as $key => $val){
        print "<td> $val[$i]"; 
    }
    print "</TR>\n";
}

print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>
