select *
from {{ source('cta', 'core_actionnotification_to_staff_base') }}
