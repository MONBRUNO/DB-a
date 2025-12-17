declare
    type s_ty is table of varchar2(100);
    type csr_ty is ref cursor;
    csr     csr_ty;
    keys    s_ty := s_ty('and', 'or', 'of', 'love', '%', 'ar');
    mv_str constant varchar2(200) := 'select * from movie where title like ''%''||:1||''%'' ';
    avg_str constant varchar2(200) := 'select avg(length) from movie where title like ''%''||:1||''%'' ';
    r_str   varchar2(200);
    a_str   varchar2(200);
    m   movie%rowtype;
    avg_len float;
    length_key  constant    int := 90;
    key_str varchar2(50);
begin
    for i in keys.first..keys.last loop
        if keys(i) = '%' then
            r_str := mv_str || ' escape ''@'' ';
            a_str := avg_str || ' escape ''@'' ';
            key_str := '@'||keys(i);
        else
            r_str := mv_str;
            a_str := avg_str;
            key_str := keys(i);
        end if;
        if mod(i,2) = 0 then
            r_str := r_str || ' and length > :2';
            a_str := a_str || ' and length > :2';
            execute immediate a_str into avg_len using key_str, length_key;
            open csr for r_str using key_str, length_key;
        else
            execute immediate a_str into avg_len using key_str;
            open csr for r_str using key_str;
        end if;
        dbms_output.put_line('['||i||'] '||keys(i)||
            '를 제목에 포함한 영화 : 평균 상영시간- '||round(avg_len,2));
        loop
            fetch csr into m;
            exit when csr%notfound;
            dbms_output.put_line('  -'||m.title||'('||m.year||') 상영시간:'||m.length);
        end loop;
        close csr;
    end loop;
end;