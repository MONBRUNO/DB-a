CREATE or REPLACE PROCEDURE get_movie
    (tt varchar2, yy movie.year%type, 
    len out movie.length%type, sname out movie.studioname%type)
is
begin
    select length, studioname into len, sname
    from movie
    where title = tt and year = yy;
EXCEPTION
    when others then
        len := -1;
        sname := null;
end;