select *
from {{ source('cta', 'core_actionnotification_base') }}
