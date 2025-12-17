<?php
// for correct error message outputs
//putenv("NLS_LANG=KOREAN_KOREA.AL32UTF8");

function p_error($id=null){
    if($id==null)$e=oci_error();
    else $e = oci_error($id);
    print htmlentities($e['message']);
    exit();
}

$conn = oci_connect("db2021863026","db98716545", "localhost/lecture");
if(!$conn)    p_error();

//$title = $_GET["title"];
//$year = $_GET["year"];

$stmt = oci_parse($conn,
	"select title, year, length, studioname as name, s.address addr, e.name boss from movie, studio s,movieexec e ".
	" where studioname = s.name and presno = e.certno order by 1, 2 ");
if (!$stmt) p_error($conn);

/* the define MUST be done BEFORE ociexecute! */
oci_define_by_name($stmt,"TITLE",$title);
oci_define_by_name($stmt,"YEAR",$year);
oci_define_by_name($stmt,"LENGTH",$length);
oci_define_by_name($stmt,"NAME",$studio);
oci_define_by_name($stmt,"ADDR",$addr);
oci_define_by_name($stmt,"BOSS",$boss);

$r = oci_execute($stmt);
if (!$r) p_error ($stmt);

print "<TABLE bgcolor=#abbcbabc border=1 cellspacing=2>\n";
print "<TR bgcolor=#1ebcbabf align=center><TH> 제목 <TH> 연도 <TH> 상영시간 <TH> 영화사</TR>\n";

while (oci_fetch($stmt)) {
    print "<TR> <TD> $title <TD> ".$year."년도 <TD> {$length}분<TD> <font color=red><b>$studio</b></font>(사장:$boss, 주소:$addr) </TR>\n";
}
print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>
