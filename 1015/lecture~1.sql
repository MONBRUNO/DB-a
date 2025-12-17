select to_char (birthdate, 'yyyy')||'년'  ||
        to_char (birthdate, 'mm')||'월'  ||
        to_char (birthdate, 'dd')||'일'  ||
from moviestar;
select to_char (birthdate, '""yyyy"년" "mm"월" "dd"일" ')
from moviestar;