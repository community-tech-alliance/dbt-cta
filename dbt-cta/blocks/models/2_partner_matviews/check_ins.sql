select *
from {{ source('cta', 'check_ins_base') }}
