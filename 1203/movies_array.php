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
if(!$conn) p_error();

$title = str_replace("","", $_GET["title"]);
$year = $_GET["year"];
if(!empty($title)&&!empty($year))
    $cond="title='$title'and year=$year and";
else
    $cond = "";
$stmt = oci_parse($conn,
	"select title, year, length, studioname as name, s.address addr, e.name boss from movie, studio s,movieexec e ".
	" where $cond studioname = s.name and presno = e.certno order by 1, 2 ");
if (!$stmt) p_error($conn);

$r = oci_execute($stmt);
if (!$r) p_error ($stmt);

print "<TABLE bgcolor=#abbcbab<?php
// for correct error message outputs
//putenv("NLS_LANG=KOREAN_KOREA.AL32UTF8");

function p_error($id=null) {
    if($id == null) $e = oci_error();
    else $e = oci_error($id);
    print htmlentities($e['message']);
    exit();
}

$conn = oci_connect("scott","tiger", "localhost/lecture");
if (!$conn)    p_error();

$title = str_replace("'", "''", $_GET["title"]);
$year = $_GET["year"];

if(!empty($title) && !empty($year)) 
    $cond = " title = '$title' and year = $year and ";
else
    $cond = "";

$stmt = oci_parse($conn,
	"select title, year, length, studioname  name, s.address addr, e.name boss from movie, studio s, movieexec e ".
	" where $cond studioname = s.name and presno = e.certno order by 1, 2 ");
if (!$stmt)    p_error($conn);

$r = oci_execute($stmt);
if (!$r) p_error ($stmt);

print "<TABLE bgcolor=#abbcbabc border=1 cellspacing=2>\n";
print "<TR bgcolor=#1ebcbabf align=center><TH> 제목 <TH> 연도 <TH> 상영시간 <TH> 영화사</TR>\n";

while ($row = oci_fetch_array($stmt)) {
    print "<TR> <TD> {$row[0]} <TD> {$row[1]}년도 <TD> {$row['LENGTH']}분"
                . "<TD> <font color=blue><b>{$row['NAME']}</b></font>(사장:{$row['BOSS']}, 주소: {$row['ADDR']}) </TR>\n";
}
print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>
c border=1 cellspacing=2>\n";
print "<TR bgcolor=#1ebcbabf align=center><TH> 제목 <TH> 연도 <TH> 상영시간 <TH> 영화사</TR>\n";

while ($row = oci_fetch_array($stmt)) {
    print "<TR> <TD> {$row[0]} <TD> {$row[1]}년도 <TD> {$row['LENGTH']}분"
        ."<TD> <font color=blue><b>{$row['NAME']}</b></font>(사장:{$row['BOSS']}, 주소:{$row['ADDR']}) </TR>\n";
}
print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>
