select p.name, p.birthdate, ph.*, a.*
from people p, table(p.phone_list) ph, table(p.addresses) a;