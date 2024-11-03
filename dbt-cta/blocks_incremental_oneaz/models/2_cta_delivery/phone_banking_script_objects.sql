select *
from {{ source('cta', 'phone_banking_script_objects_base') }}
