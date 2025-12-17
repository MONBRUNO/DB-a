<?php
function p_error($msg, $id=null) {
    print "<font color=red>".$msg."</font><br>";
    if($id == null) $e = oci_error();
    else $e = oci_error($id);
    print htmlentities($e['message']);
    print "\n<pre>\n";
    print htmlentities($e['sqltext']);
    printf("\n%".($e['offset']+1)."s", "^");
    print  "\n</pre>\n";
    exit();
}
function movie_exists($title,$year,$conn){
    $stmt = oci_parse($conn, "select * from movie where title=:1 and year=$year");
    if (!$stmt)    p_error("Parsing Error", $conn);
oci_bind_by_name($stmt, ":1", $title);
    if (!oci_execute($stmt)) p_error ("Execution Error", $stmt);
    $n= oci_fetch_all($stmt, $r);
    oci_free_statement($stmt);
    if($n > 0) return true;
    else    return false;
}

$conn = oci_connect("db2021863026","db98716545", "localhost/lecture");
if (!$conn)    p_error("Connection Error");

$title = $_POST["title"];
$year = $_POST["year"];
$length = $_POST["length"];
$pno = $_POST["pno"];
$sname = $_POST["sname"];
$submit = $_POST["submit"];
$search = $insert = $update = false;
if(!empty($submit)){
    switch ($submit){
        case "검색" :
            $search = true;
            break;
        case "삽입" :
            $insert = true;
            break;
        case "갱신" :
            $update = true;
            break;
        default:
            break;
    }
}
$mv = $_POST["mv"];
if(!empty($mv)){
    foreach ($mv as $v){
        $ttyy = explode("|", $v);
        $tt=$ttyy[0];
        $yy=$ttyy[1];
        
        if(!movie_exists($tt, $yy, $conn)){
            print "Movie($tt, $yy)튜플 없음 <br>";
        } else {
            $stmt = oci_parse($conn, "delete from movie where title=:1 and year=$yy");
            if (!$stmt)    p_error("Parsing Error", $conn);
            oci_bind_by_name($stmt, ":1", $tt);
            if (!oci_execute($stmt)) p_error ("Deletion Error", $stmt);
            print "-Movie($tt, $yy) 튜플 삭제됨.<br>";
        }
    }
}
if($insert){
    $stmt = oci_parse($conn, "insert into movie values (:tt, :yy, :len, 't', :sn, :pno) ");
    if (!$stmt)    p_error("Parsing Error", $conn);
    oci_bind_by_name($stmt, ":tt", $title);
    oci_bind_by_name($stmt, ":yy", $year);
    oci_bind_by_name($stmt, ":len", $length);
    oci_bind_by_name($stmt, ":sn", $sname);
    oci_bind_by_name($stmt, ":pno", $pno);
    if (!oci_execute($stmt)) p_error ("Insertion Error", $stmt);
    print "-Movie($tt, $yy) 튜플 삽입됨.<br>";
}
if($update){
    $stmt = oci_parse($conn, "update movie ". 
                                "set length = :len, studioname = :sn, producerno = :pno     "
                                ."where title = :tt and year = :yy ");
    if (!$stmt)    p_error("Parsing Error", $conn);
    oci_bind_by_name($stmt, ":tt", $title);
    oci_bind_by_name($stmt, ":yy", $year);
    oci_bind_by_name($stmt, ":len", $length);
    oci_bind_by_name($stmt, ":sn", $sname);
    oci_bind_by_name($stmt, ":pno", $pno);
    if (!oci_execute($stmt)) p_error ("Update Error", $stmt);
    print "-Movie($tt, $yy) 튜플 갱신 됨.<br>";
}
$where = "";
if(!empty($title)){
    if(strlen($where) > 0) $where = $where . " and ";
    $where = $where . "title like '%' || :tt || '%' ";
}
if(!empty($year)){
    if(strlen($where) > 0) $where = $where . " and ";
    $where = $where . "year = :yy";
}
if(!empty($length)){
    if(strlen($where) > 0) $where = $where . " and ";
    $where = $where . "length = $length";
}
if(!empty($pno)){
    if(strlen($where) > 0) $where = $where . " and ";
    $where = $where . "producerno = $pno ";
}
if(!empty($sname)){
    if(strlen($where) > 0) $where = $where . " and ";
    $where = $where . "studioname = '$sname' ";
}

if(strlen($where) > 0) $where = " where " . $where;

$stmt = oci_parse($conn,
	"select title, year, length, studioname, name from movie left outer join movieexec on producerno = certno ".
	"$where order by 1, 2 ");
if (!$stmt)    p_error("Parsing Error", $conn);
oci_bind_by_name($stmt, ":tt", $title);
oci_bind_by_name($stmt, ":yy", $year);
if (!oci_execute($stmt)) p_error ("Execution Error", $stmt);

print "<form method='post' action='movie_manage.php'>\n";
print "<TABLE bgcolor=#abbcbabc border=1 cellspacing=2>\n";
print "<TR bgcolor=#1ebcbabf align=center><TH> 제목 <TH> 연도 <TH> 상영시간 <TH> 영화사 <th> 제작자 <th> 삭제 </TR>\n";

$n = oci_fetch_all($stmt, $row);
for ($i=0; $i < $n; $i++) {
    print "<tr> ";
    foreach ($row as $key => $val) {
        print "<td> {$val[$i]} ";
    }
    $tt= htmlentities($row['TITLE'][$i], ENT_QUOTES);
    $yy=$row['YEAR'][$i];
    print "<td> <input type='checkbox' name='mv[]' value='$tt|$yy'>";
    print "</tr>\n ";
}
print "<tr> <td colspan=6> <input type='submit' name='submit' value='delete'> </tr>\n";
print "</TABLE>\n";
print "</form>\n";
oci_free_statement($stmt);
oci_close($conn);
?>
