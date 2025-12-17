<?php
function p_error($id=null){
    if($id==null)$e=oci_error();
    else $e = oci_error($id);
    print htmlentities($e['message']);
    exit();
}

$conn = oci_connect("db2021863026","db98716545","localhost/lecture");
if(!$conn) p_error();

$stmt = oci_parse($conn,
    "select certno, name, address
     from movieexec
     order by name"
);
if(!$stmt) p_error($conn);

$r = oci_execute($stmt);
if(!$r) p_error($stmt);

$nexec = oci_fetch_all($stmt, $execs, 0, -1, OCI_FETCHSTATEMENT_BY_ROW);

print "<TABLE style='background-color:white;color:black' border=1 cellspacing=2 cellpadding=4>\n";
print "<TR bgcolor=#ffddee align=center><TH> 순번 <TH> 이름 <TH> 주소 <TH> 영화사 <TH> 제작 영화 <TH> 출연 영화</TR>\n";

for($i=0; $i<$nexec; $i++){
    $ex = $execs[$i];
    $cert = $ex['CERTNO'];
    $ename = $ex['NAME'];
    $eaddr = $ex['ADDRESS'];

    $stmt2 = oci_parse($conn,
        "select name
         from studio
         where presno = :c
         order by name"
    );
    if(!$stmt2) p_error($conn);
    oci_bind_by_name($stmt2, ":c", $cert);
    $r2 = oci_execute($stmt2);
    if(!$r2) p_error($stmt2);

    $nstudio = oci_fetch_all($stmt2, $studios, 0, -1, OCI_FETCHSTATEMENT_BY_ROW);

    if($nstudio == 0){
        $studio_txt = "없음";
    } else {
        $studio_txt = $studios[0]['NAME'];
        for($j=1; $j<$nstudio; $j++){
            $studio_txt .= "<br>".$studios[$j]['NAME'];
        }
    }
    oci_free_statement($stmt2);

    $stmt3 = oci_parse($conn,
        "select title, year
         from movie
         where producerno = :c
         order by year, title"
    );
    if(!$stmt3) p_error($conn);
    oci_bind_by_name($stmt3, ":c", $cert);
    $r3 = oci_execute($stmt3);
    if(!$r3) p_error($stmt3);

    $nprod = oci_fetch_all($stmt3, $prods, 0, -1, OCI_FETCHSTATEMENT_BY_ROW);

    if($nprod == 0){
        $prod_txt = "없음";
    } else {
        $prod_txt = $prods[0]['TITLE']."(".$prods[0]['YEAR'].")";
        for($j=1; $j<$nprod; $j++){
            $prod_txt .= "<br>".$prods[$j]['TITLE']."(".$prods[$j]['YEAR'].")";
        }
    }
    oci_free_statement($stmt3);

    $stmt4 = oci_parse($conn,
        "select m.title, m.year
         from movie m, starsin si
         where si.starname = :n
           and si.movietitle = m.title
           and si.movieyear = m.year
         order by m.year, m.title"
    );
    if(!$stmt4) p_error($conn);
    oci_bind_by_name($stmt4, ":n", $ename);
    $r4 = oci_execute($stmt4);
    if(!$r4) p_error($stmt4);

    $nstar = oci_fetch_all($stmt4, $stars, 0, -1, OCI_FETCHSTATEMENT_BY_ROW);

    if($nstar == 0){
        $star_txt = "없음";
    } else {
        $star_txt = $stars[0]['TITLE']."(".$stars[0]['YEAR'].")";
        for($j=1; $j<$nstar; $j++){
            $star_txt .= "<br>".$stars[$j]['TITLE']."(".$stars[$j]['YEAR'].")";
        }
    }
    oci_free_statement($stmt4);

    $seq = $i + 1;
    print "<TR> <TD> ".$seq." <TD> ".$ename." <TD> ".$eaddr." <TD> ".$studio_txt." <TD> ".$prod_txt." <TD> ".$star_txt." </TR>\n";
}

print "</TABLE>\n";
print "</body></html>\n";

oci_free_statement($stmt);
oci_close($conn);
?>
