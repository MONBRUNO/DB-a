<?php
function p_error($id=null){
    if($id==null)$e=oci_error();
    else $e = oci_error($id);
    print htmlentities($e['message']);
    exit();
}

$conn = oci_connect("db2021863026","db98716545","localhost/lecture");
if(!$conn) p_error();

$title_in = isset($_GET["title"]) ? $_GET["title"] : "";
$like_opt = isset($_GET["like_opt"]) ? $_GET["like_opt"] : "";
$case_opt = isset($_GET["case_opt"]) ? $_GET["case_opt"] : "";
$len1 = isset($_GET["len1"]) ? $_GET["len1"] : "";
$len2 = isset($_GET["len2"]) ? $_GET["len2"] : "";
$byear = isset($_GET["byear"]) ? $_GET["byear"] : "";
$gender = isset($_GET["gender"]) ? $_GET["gender"] : "";

$cond = "1=1";

if($title_in != ""){
    $etitle = str_replace("'", "''", $title_in);

    if($like_opt != ""){
        $pattern = "%".$etitle."%";
        if($case_opt != ""){
            $cond .= " and m.title like '".$pattern."'";
        } else {
            $cond .= " and upper(m.title) like upper('".$pattern."')";
        }
    } else {
        if($case_opt != ""){
            $cond .= " and m.title = '".$etitle."'";
        } else {
            $cond .= " and upper(m.title) = upper('".$etitle."')";
        }
    }
}

if($len1 != ""){
    $cond .= " and m.length >= ".$len1;
}
if($len2 != ""){
    $cond .= " and m.length <= ".$len2;
}

if($byear != ""){
    $cond .= " and exists (select 1 from starsin si, moviestar ms"
           . " where si.movietitle = m.title and si.movieyear = m.year"
           . " and si.starname = ms.name"
           . " and ms.birthdate > to_date('".$byear."-01-01','yyyy-mm-dd'";
    if($gender != ""){
        $cond .= " and ms.gender = '".$gender."'";
    }
    $cond .= "))";
}

$sql = "select m.title, m.year, p.name producer, s.name sname, s.address saddr
        from movie m, movieexec p, studio s
        where m.producerno = p.certno and m.studioname = s.name and ".$cond."
        order by m.year, m.title";

$stmt = oci_parse($conn, $sql);
if(!$stmt) p_error($conn);

$r = oci_execute($stmt);
if(!$r) p_error($stmt);

$nrows = oci_fetch_all($stmt, $rows, 0, -1, OCI_FETCHSTATEMENT_BY_ROW);

print "<TABLE style='background-color:white;color:black' border=1 cellspacing=2 cellpadding=5>\n";
print "<TR bgcolor=#ccccff align=center><TH> 제목 <TH> 개봉년도 <TH> 제작자 <TH> 영화사 <TH> 영화사 주소</TR>\n";

for($i=0; $i<$nrows; $i++){
    $mv = $rows[$i];
    $title = $mv['TITLE'];
    $show_title = $title;

    if($like_opt != "" && $title_in != ""){
        $show_title = str_replace($title_in, "<span style='background-color:yellow;'>".$title_in."</span>", $title);
    }

    print "<TR> <TD> ".$show_title." <TD> ".$mv['YEAR']."년 <TD> ".$mv['PRODUCER']." <TD> ".$mv['SNAME']." <TD> ".$mv['SADDR']." </TR>\n";
}

print "</TABLE>\n";
print "</body></html>\n";

oci_free_statement($stmt);
oci_close($conn);
?>
