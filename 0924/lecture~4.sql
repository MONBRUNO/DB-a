var len NUMBER
var sname VARCHAR2

execute get_movie('Star wars', 1983, :len, :sname)
print len
print sname