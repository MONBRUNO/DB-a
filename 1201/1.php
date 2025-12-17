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
    "select  m.title, m.year, m.length, p.name as producer, b.name as boss
     from movie m, movieexec p, studio s, movieexec b
     where m.producerno = p.certno and m.studioname = s.name and s.presno = b.certno
     order by m.year, m.length"
);
if (!$stmt) p_error($conn);

$r = oci_execute($stmt);
if (!$r) p_error ($stmt);

print "<TABLE bgcolor=#eeeeee border=1 cellspacing=2>\n ";
print "<TR bgcolor=#cccccc align=center><TH> 제목 <TH> 년도 <TH> 상영시간 <TH> 제작자 <TH> 영화사사장 <TH> 출연배우수 <TH> 출연배우진</TR>\n";

while($row = oci_fetch_array($stmt)){

    $title = $row[0];
    $year  = $row[1];

    $st = oci_parse($conn,
        "select ms.name
         from starsin si, moviestar ms
         where si.movietitle = :t and si.movieyear = :y and si.starname = ms.name
         order by ms.birthdate desc"
    );
    if(!$st) p_error($conn);

    oci_bind_by_name($st, ":t", $title);
    oci_bind_by_name($st, ":y", $year);

    $r2 = oci_execute($st);
    if(!$r2) p_error($st);

    $stars = array();
    while($srow = oci_fetch_array($st)){
        $stars[] = $srow['NAME'];
    }
    $scnt = count($stars);

    if($scnt > 0){
        $starlist = $stars[0];
        for($i=1; $i<$scnt; $i++){
            $starlist .= ", ".$stars[$i];
        }
    } else {
        $starlist = "정보없음";
    }

    print "<TR> <TD> {$row[0]} <TD> {$row[1]}년 <TD> {$row[2]}분 <TD> {$row['PRODUCER']} <TD> {$row['BOSS']} <TD> ".($scnt>0 ? $scnt.'명' : '정보없음')." <TD> {$starlist} </TR>\n";

    oci_free_statement($st);
}

print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>