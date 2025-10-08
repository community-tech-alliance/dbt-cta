select *
from {{ source('cta', 'core_usergroup_base') }}
