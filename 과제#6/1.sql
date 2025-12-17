declare
  type str_tab is table of varchar2(100);
  v_terms str_tab := str_tab('uk', '_', 'california', 'ZZZ', 'new york', 'texas', 'chicago');

  v_pat      varchar2(400);
  v_avg      number;

  v_avg_sql  varchar2(1000) := 
      'select avg(networth) from movieexec '||
      ' where address is not null and lower(address) like :pat escape ''\'' ';

  v_list_sql varchar2(2000) := 
      'select name, address, networth from movieexec '||
      ' where address is not null and lower(address) like :pat escape ''\'' '||
      ' order by lower(name)';

  type rc_t is ref cursor;
  rc        rc_t;

  v_name    movieexec.name%type;
  v_addr    movieexec.address%type;
  v_net     movieexec.networth%type;
  k         pls_integer;
begin
  for i in 1..v_terms.count loop
    if v_terms(i) = '_' then
      v_pat := '%\_%';
    else
      v_pat := '%' || lower(v_terms(i)) || '%';
    end if;

    execute immediate v_avg_sql into v_avg using v_pat;

    if v_avg is null then
      dbms_output.put_line('['||i||'] '||v_terms(i)||' 가주소에있는임원들 : 해당정보없음.');
      dbms_output.put_line('');
    else
      dbms_output.put_line('['||i||'] '||v_terms(i)||
        ' 가주소에있는임원들 : 평균재산액수 - '||
        to_char(v_avg, 'FM999G999G999G990D00', 'NLS_NUMERIC_CHARACTERS=.,')||'원');

      k := 0;
      open rc for v_list_sql using v_pat;
      loop
        fetch rc into v_name, v_addr, v_net;
        exit when rc%notfound;
        k := k + 1;
        dbms_output.put_line(
          '('||k||') '||v_name||'('||v_addr||'에거주) : 재산 : '||
          to_char(v_net, 'FM999G999G999G990D00', 'NLS_NUMERIC_CHARACTERS=.,')||'원'
        );
      end loop;
      close rc;

      dbms_output.put_line('');
    end if;
  end loop;
end;